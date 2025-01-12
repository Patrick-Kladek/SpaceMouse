//
//  SpaceMouse.m
//  MetallSplatter
//
//  Created by Patrick Kladek on 11.01.25.
//

#import <3DConnexionClient/ConnexionClient.h>
#import <3DConnexionClient/ConnexionClientAPI.h>
#import <Cocoa/Cocoa.h>
#import "MotionEvent.h"
#import "SpaceMouse.h"


extern int16_t SetConnexionHandlers(ConnexionMessageHandlerProc messageHandler, ConnexionAddedHandlerProc addedHandler, ConnexionRemovedHandlerProc removedHandler, bool useSeparateThread) __attribute__((weak_import));
void messageUpdateHandler(io_connect_t connection, natural_t messageType, void *messageArgument);


@interface SpaceMouse ()

@property (atomic) NSThread *connexionThread;

@end


@implementation SpaceMouse

- (instancetype)init
{
	if (SetConnexionHandlers == NULL) {
		return nil;
	}

	self = [super init];
	if (self) {

	}
	return self;
}

+ (SpaceMouse *)sharedInstance
{
	static SpaceMouse *sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[SpaceMouse alloc] init];
	});
	return sharedInstance;
}

- (void)connect
{
	self.connexionThread = [[NSThread alloc] initWithTarget:self selector:@selector(_main) object:nil];
	self.connexionThread.name = @"Space Mouse";
	[self.connexionThread start];
}

- (void)disconnect
{
	if (self.clientID) {
		UnregisterConnexionClient(self.clientID);
	}
	CleanupConnexionHandlers();
	[self.connexionThread cancel];
}

// MARK: - Internal

- (void)eventReceived:(MotionEvent *)event
{
	if ([self.delegate respondsToSelector:@selector(spaceMouse:didReceiveEvent:)]) {
		[self.delegate spaceMouse:self didReceiveEvent:event];
	}
}

- (void)buttonPressed:(uint32_t)button
{
	if ([self.delegate respondsToSelector:@selector(spaceMouse:buttonPressed:)]) {
		[self.delegate spaceMouse:self buttonPressed:(SpaceMouseButton)button];
	}
}

// MARK: - Private

- (void)_start3DMouse
{
	OSErr error;

	// Make sure the framework is installed
	if (SetConnexionHandlers == NULL) {
		NSLog(@"SpaceMouse Framework not found");
	}
	// Install message handler and register our client
	error = SetConnexionHandlers(messageUpdateHandler, 0L, 0L, NO);

	// This takes over system-wide
	_clientID = RegisterConnexionClient(kConnexionClientWildcard, NULL, kConnexionClientModeTakeOver, kConnexionMaskAll);
}

- (void)_main
{
	NSRunLoop *runLoop = [NSRunLoop currentRunLoop];

	[self _start3DMouse];
	while ([[NSThread currentThread] isCancelled] == NO) {
	  // Run the run loop but timeout immediately if the input source isn't waiting to fire.
	  [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
	}
}

@end

void messageUpdateHandler(io_connect_t connection, natural_t messageType, void *messageArgument)
{
	ConnexionDeviceState *state;

	switch(messageType) {
		case kConnexionMsgDeviceState:
			state = (ConnexionDeviceState*)messageArgument;
			if (state->client == SpaceMouse.sharedInstance.clientID) {
				// decipher what command/event is being reported by the driver
				switch (state->command) {
					case kConnexionCmdHandleAxis: {
						MotionEvent *event = [[MotionEvent alloc] initWithConnexionDeviceState:state];
						[SpaceMouse.sharedInstance eventReceived:event];
					}
						break;
					case kConnexionCmdHandleButtons: {
						[SpaceMouse.sharedInstance buttonPressed:state->buttons];
					}
					case kConnexionCmdAppSpecific:
						break;
					case kConnexionCmdHandleRawData:
						break;
					default:
						break;
				}
			}
			break;
		case kConnexionMsgPrefsChanged:
			break;
		default:
			// other messageTypes can happen and should be ignored
			break;
	}
}

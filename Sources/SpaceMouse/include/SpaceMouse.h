//
//  SpaceMouse.h
//  MetallSplatter
//
//  Created by Patrick Kladek on 11.01.25.
//

#import <Foundation/Foundation.h>
#import "MotionEvent.h"


NS_ASSUME_NONNULL_BEGIN

@class SpaceMouse;

typedef NS_ENUM(NSUInteger, SpaceMouseButton) {
	SpaceMouseButtonMenu 	= 0b00000001,
	SpaceMouseButtonFit 	= 0b00000010,

	SpaceMouseButtonTop 	= 0b00000100,
	SpaceMouseButtonRight	= 0b00010000,
	SpaceMouseButtonFront 	= 0b00100000,
};

@protocol SpaceMouseDelegate <NSObject>

- (void)spaceMouse:(SpaceMouse *)mouse didReceiveEvent:(MotionEvent *)event;
- (void)spaceMouse:(SpaceMouse *)mouse buttonPressed:(SpaceMouseButton)button;

@end


@interface SpaceMouse : NSObject

@property (class, nonatomic, readonly) SpaceMouse *sharedInstance;
@property (nonatomic, weak) id<SpaceMouseDelegate> delegate;
@property (nonatomic, readonly) UInt16 clientID;

- (instancetype)init NS_UNAVAILABLE;

- (void)connect;

@end

NS_ASSUME_NONNULL_END

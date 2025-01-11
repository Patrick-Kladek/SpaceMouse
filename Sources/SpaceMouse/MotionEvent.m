//
//  MotionEvent.m
//  MetallSplatter
//
//  Created by Patrick Kladek on 11.01.25.
//

#import "MotionEvent.h"


@implementation MotionEvent

- (instancetype)initWithConnexionDeviceState:(ConnexionDeviceState *)state
{
	self = [super init];
	if (self) {
		_tx = state->axis[0];
		_ty = state->axis[1];
		_tz = state->axis[2];
		_rx = state->axis[3];
		_ry = state->axis[4];
		_rz = state->axis[5];
		_timeStamp = NSDate.now.timeIntervalSince1970;
	}
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%4li %4li %4li / %4li %4li %4li", (long)self.tx, (long)self.ty, (long)self.tz, (long)self.rx, (long)self.ry, (long)self.rz];
}

@end

//
//  MotionEvent.h
//  SpaceMouse
//
//  Created by Patrick Kladek on 11.01.25.
//

#import <Foundation/Foundation.h>
@import ConnexionClient;

NS_ASSUME_NONNULL_BEGIN


@interface MotionEvent: NSObject

@property (readonly, assign) NSInteger tx;
@property (readonly, assign) NSInteger ty;
@property (readonly, assign) NSInteger tz;
@property (readonly, assign) NSInteger rx;
@property (readonly, assign) NSInteger ry;
@property (readonly, assign) NSInteger rz;
@property (readonly, assign) NSTimeInterval timeStamp;

- (instancetype)initWithConnexionDeviceState:(ConnexionDeviceState *)state;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

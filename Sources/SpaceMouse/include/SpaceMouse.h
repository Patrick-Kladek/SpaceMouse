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


@protocol SpaceMouseDelegate <NSObject>

- (void)spaceMouse:(SpaceMouse *)mouse didReceiveEvent:(MotionEvent *)event;

@end


@interface SpaceMouse : NSObject

@property (class, nonatomic, readonly) SpaceMouse *sharedInstance;
@property (nonatomic, weak) id<SpaceMouseDelegate> delegate;
@property (nonatomic, readonly) UInt16 clientID;

- (instancetype)init NS_UNAVAILABLE;

- (void)connect;

@end

NS_ASSUME_NONNULL_END

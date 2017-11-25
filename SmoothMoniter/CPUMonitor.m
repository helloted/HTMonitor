//
//  CPUMonitor.m
//  SmoothMoniter
//
//  Created by iMac on 2017/11/25.
//  Copyright © 2017年 iMac0. All rights reserved.
//

#import "CPUMonitor.h"
#import <QuartzCore/QuartzCore.h>

@interface CPUMonitor ()

@property (nonatomic, strong)CADisplayLink *displayLink;
@property (nonatomic, assign)CFTimeInterval last_time;
@property (nonatomic, assign)NSInteger      count;

@end

@implementation CPUMonitor

+ (instancetype)sharedInstance{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)start{
    self.displayLink.paused = NO;
    _count = 0;
    _last_time = self.displayLink.timestamp;
}

- (void)pause{
    self.displayLink.paused = YES;
}

- (void)updateTime{
    if (!_last_time) {
        _last_time = self.displayLink.timestamp;
        return;
    }
    _count ++;
    CFTimeInterval current = self.displayLink.timestamp;
    CFTimeInterval period = current - _last_time;
    if (period > 1 ) {
        NSLog(@"FPS:%@",@(_count));
        _count = 0;
        _last_time = self.displayLink.timestamp;
    }
    
}

- (CADisplayLink *)displayLink{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTime)];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _displayLink;
}


@end

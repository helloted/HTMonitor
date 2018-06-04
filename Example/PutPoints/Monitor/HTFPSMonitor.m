//
//  HTFPSMonitor.m
//  PutPoints
//
//  Created by iMac on 2018/5/30.
//  Copyright © 2018年 iMac. All rights reserved.
//

#import "HTFPSMonitor.h"
#import <QuartzCore/QuartzCore.h>

@interface HTFPSMonitor ()

@property (nonatomic, strong)CADisplayLink *displayLink;
@property (nonatomic, assign)CFTimeInterval last_time;
@property (nonatomic, assign)NSInteger      count;

@end

@implementation HTFPSMonitor

+ (instancetype)sharedInstance{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)startMonitor{
    NSLog(@"start");
    self.displayLink.paused = NO;
    _count = 0;
    _last_time = self.displayLink.timestamp;
}

- (void)stopMonitor{
    NSLog(@"stop");
    self.displayLink.paused = YES;
    [self.displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [self.displayLink invalidate];
    self.displayLink = nil;
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


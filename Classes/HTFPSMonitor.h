//
//  HTFPSMonitor.h
//  PutPoints
//
//  Created by iMac on 2018/5/30.
//  Copyright © 2018年 iMac. All rights reserved.
//  监测FPS

#import <Foundation/Foundation.h>

@interface HTFPSMonitor : NSObject

+ (instancetype)sharedInstance;

- (void)startMonitor;

- (void)stopMonitor;

@end

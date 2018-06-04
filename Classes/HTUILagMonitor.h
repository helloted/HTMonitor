//
//  HTUILagMonitor.h
//  PutPoints
//
//  Created by iMac on 2018/5/30.
//  Copyright © 2018年 iMac. All rights reserved.
//  检测UI卡顿的工具

#import <Foundation/Foundation.h>

@interface HTUILagMonitor : NSObject

+ (instancetype)sharedInstance;

- (void)startMonitor;

- (void)stopMonitor;

@end

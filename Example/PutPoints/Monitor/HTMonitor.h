//
//  HTMonitor.h
//  PutPoints
//
//  Created by iMac on 2018/5/29.
//  Copyright © 2018年 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    HTMonitorTypeAll = 0,
    HTMonitorTypeUILoadTime,  // UI 加载时间
    HTMonitorTypeUILag,  // UI卡顿检测
    HTMonitorTypeMemoryLeak,  //内存泄漏检测
    HTMonitorTypeFPS, // 监控屏幕FPS
} HTMonitorType;


@interface HTMonitor : NSObject

+ (void)startMonitor:(HTMonitorType)type;

+ (void)stopMonitor:(HTMonitorType)type;

@end

//
//  HTMonitor.m
//  PutPoints
//
//  Created by iMac on 2018/5/29.
//  Copyright © 2018年 iMac. All rights reserved.
//

#import "HTMonitor.h"
#import "UIViewController+HTMethodMonitor.h"
#import <objc/runtime.h>
#import "HTUILagMonitor.h"
#import "HTFPSMonitor.h"


void ht_monitor_exchangeInstanceMethod(Class class, SEL originalSelector, SEL newSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method newMethod = class_getInstanceMethod(class, newSelector);
    if(class_addMethod(class, originalSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(class, newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
}

static BOOL _monitorUILoadTime = NO;
static BOOL _monitorUILag = NO;
static BOOL _monitorMemoryLeak = NO;
static BOOL _monitorFPS = NO;

@implementation HTMonitor

+ (void)changeMonitorUI{
    ht_monitor_exchangeInstanceMethod(NSClassFromString(@"UIViewController"), @selector(viewDidLoad), @selector(ht_ViewDidLoad));
    ht_monitor_exchangeInstanceMethod(NSClassFromString(@"UIViewController"), @selector(viewWillAppear:), @selector(ht_viewWillAppear:));
    ht_monitor_exchangeInstanceMethod(NSClassFromString(@"UIViewController"), @selector(viewDidAppear:), @selector(ht_viewDidAppear:));
}

+ (void)changeMonitorMemory{
    ht_monitor_exchangeInstanceMethod(NSClassFromString(@"UIViewController"), @selector(viewWillDisappear:), @selector(ht_viewWillDisappear:));
    ht_monitor_exchangeInstanceMethod(NSClassFromString(@"UIViewController"), @selector(viewDidDisappear:), @selector(ht_viewDidDisappear:));
    ht_monitor_exchangeInstanceMethod(NSClassFromString(@"NSObject"), NSSelectorFromString(@"dealloc"), NSSelectorFromString(@"ht_dealloc"));
}


+ (void)startMonitor:(HTMonitorType)type{
    switch (type) {
        case HTMonitorTypeAll:{
            if (!_monitorUILoadTime) {
                [self changeMonitorUI];
                _monitorUILoadTime = YES;
            }
            if (!_monitorMemoryLeak) {
                [self changeMonitorMemory];
                _monitorMemoryLeak = YES;
            }
        }break;
        case HTMonitorTypeUILoadTime:{
            if (!_monitorUILoadTime) {
                [self changeMonitorUI];
                _monitorUILoadTime = YES;
            }
        }break;
        case HTMonitorTypeMemoryLeak:{
            if (!_monitorMemoryLeak) {
                [self changeMonitorMemory];
                _monitorMemoryLeak = YES;
            }
        }break;
        case HTMonitorTypeUILag:{
            if (!_monitorUILag) {
                [[HTUILagMonitor sharedInstance] startMonitor];
                _monitorUILag = YES;
            }
        }break;
        case HTMonitorTypeFPS:{
            if (!_monitorFPS) {
                [[HTFPSMonitor sharedInstance] startMonitor];
                _monitorFPS = YES;
            }
        }break;
    }
}

+ (void)stopMonitor:(HTMonitorType)type{
    switch (type) {
        case HTMonitorTypeAll:{
            if (_monitorUILoadTime) {
                [self changeMonitorUI];
                _monitorUILoadTime = NO;
            }
            if (_monitorMemoryLeak) {
                [self changeMonitorMemory];
                _monitorMemoryLeak = NO;
            }
        }break;
        case HTMonitorTypeUILoadTime:{
            if (_monitorUILoadTime) {
                [self changeMonitorUI];
                _monitorUILoadTime = NO;
            }
        }break;
        case HTMonitorTypeMemoryLeak:{
            if (_monitorMemoryLeak) {
                [self changeMonitorMemory];
                _monitorMemoryLeak = NO;
            }
        }break;
        case HTMonitorTypeUILag:{
            if (_monitorUILag) {
                [[HTUILagMonitor sharedInstance] stopMonitor];
                _monitorUILag = NO;
            }
        }break;
        case HTMonitorTypeFPS:{
            if (_monitorFPS) {
                [[HTFPSMonitor sharedInstance] stopMonitor];
                _monitorFPS = NO;
            }
        }break;
    }
}


@end


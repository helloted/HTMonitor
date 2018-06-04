//
//  UIViewController+HTMethodMonitor.m
//  PutPoints
//
//  Created by iMac on 2017/11/26.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "UIViewController+HTMethodMonitor.h"
#import <objc/runtime.h>
#import "NSObject+HTMemoryLeak.h"

static const void *didLoadKey = &didLoadKey;
static const void *ht_dellocBlockey = &ht_dellocBlockey;

@implementation UIViewController (HTMethodMonitor)


- (void)ht_ViewDidLoad{
    long current =  [[NSDate date] timeIntervalSince1970]*1000;
    self.didLoadTime = @(current);
    [self ht_ViewDidLoad];
}

- (void)ht_viewWillAppear:(BOOL)animated{
    [self ht_viewWillAppear:animated];
}


- (void)ht_viewDidAppear:(BOOL)animated{
    long didload = self.didLoadTime.longValue;
    if (didload!=0) {
        long current =  [[NSDate date] timeIntervalSince1970]*1000;
        long pass = current - didload;
        // 用于埋点监测UI渲染时间
        NSLog(@"%@渲染UI用时:%@毫秒",NSStringFromClass([self class]),@(pass));
        self.didLoadTime = @(0);
    }
    [self ht_viewDidAppear:animated];
}

- (void)ht_viewWillDisappear:(BOOL)animated{
    [self ht_viewWillDisappear:animated];
    if(self.isMovingFromParentViewController || self.isBeingDismissed){//将要被pop或者dismiss出去
        [self ht_willDealloc];
        [self ht_allVarsWillDealloc];
    }
}

- (void)ht_viewDidDisappear:(BOOL)animated{
    [self ht_viewDidDisappear:animated];
}

#pragma mark Getter Setter

- (NSNumber *)didLoadTime{
    return objc_getAssociatedObject(self, didLoadKey);
}

- (void)setDidLoadTime:(NSNumber *)didLoadTime{
    objc_setAssociatedObject(self, didLoadKey, didLoadTime, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (void)setHt_dellocBlock:(dispatch_block_t)ht_dellocBlock{
    objc_setAssociatedObject(self, ht_dellocBlockey, ht_dellocBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (dispatch_block_t)ht_dellocBlock{
    return objc_getAssociatedObject(self, ht_dellocBlockey);
}


@end

//
//  SmoothMoniter.m
//  SmoothMoniter
//
//  Created by iMac0 on 2017/4/18.
//  Copyright © 2017年 iMac0. All rights reserved.
//

#import "SmoothMoniter.h"
#import <libkern/OSAtomic.h>
#import <execinfo.h>


@interface SmoothMoniter ()

@property (nonatomic, assign)CFRunLoopActivity    activity;
@property (nonatomic, strong)dispatch_semaphore_t     semaphore;
@property (nonatomic, assign)CFRunLoopObserverRef  observer;
@property (nonatomic, assign)NSInteger            countTime;

@end

@implementation SmoothMoniter


+ (instancetype)sharedInstance{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (void)startMoniter{
    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
    _observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                        kCFRunLoopAllActivities,
                                        YES,
                                        0,
                                        &runLoopObserverCallBack,
                                        &context);
    CFRunLoopAddObserver(CFRunLoopGetMain(), _observer, kCFRunLoopCommonModes);
    
    // 创建信号
    _semaphore = dispatch_semaphore_create(0);
    
    // 在子线程监控时长
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (YES)
        {
            NSLog(@"smooth--monitering");
            //100ms则将堆栈记录下来
            long st = dispatch_semaphore_wait(_semaphore, dispatch_time(DISPATCH_TIME_NOW, 100*NSEC_PER_MSEC));
            if (st != 0)
            {
                if (_activity==kCFRunLoopBeforeSources || _activity==kCFRunLoopAfterWaiting)
                {
                    [self logStack];
                }
            }
        }
    });
}


static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    SmoothMoniter *instrance = [SmoothMoniter sharedInstance];
    instrance.activity = activity;
    dispatch_semaphore_t semaphore = instrance.semaphore;
    dispatch_semaphore_signal(semaphore);
}

- (void)endMoniter{
    if (!_observer) {
        return;
    }
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), _observer, kCFRunLoopCommonModes);
    CFRelease(_observer);
    _observer = NULL;
}


- (void)logStack{
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    int i;
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for ( i = 0 ; i < frames ; i++ ){
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
}



@end

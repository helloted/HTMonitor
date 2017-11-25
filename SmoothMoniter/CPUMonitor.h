//
//  CPUMonitor.h
//  SmoothMoniter
//
//  Created by iMac on 2017/11/25.
//  Copyright © 2017年 iMac0. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPUMonitor : NSObject

+ (instancetype)sharedInstance;

- (void)start;


@end

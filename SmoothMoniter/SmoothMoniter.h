//
//  SmoothMoniter.h
//  SmoothMoniter
//
//  Created by iMac0 on 2017/4/18.
//  Copyright © 2017年 iMac0. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SmoothMoniter : NSObject

+ (instancetype)sharedInstance;

- (void)startMoniter;

- (void)endMoniter;

@end

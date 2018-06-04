//
//  NSObject+HTMemoryLeak.h
//  HTRefresh
//
//  Created by iMac on 2018/5/29.
//  Copyright © 2018年 HelloTed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HTMemoryLeak)

- (void)ht_willDealloc;

- (void)ht_allVarsWillDealloc;

@end

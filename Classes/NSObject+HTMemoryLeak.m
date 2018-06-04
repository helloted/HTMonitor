//
//  NSObject+HTMemoryLeak.m
//  HTRefresh
//
//  Created by iMac on 2018/5/29.
//  Copyright © 2018年 HelloTed. All rights reserved.
//

#import "NSObject+HTMemoryLeak.h"
#import <objc/runtime.h>

static const void *ht_dellocBlockey = &ht_dellocBlockey;

@implementation NSObject (HTMemoryLeak)

- (void)ht_willDeallocWithOwner:(NSString *)owner ivar:(NSString *)varName{
    self.ht_dellocBlock = dispatch_block_create(0, ^{
        NSLog(@"%@.%@ 可能存在内存泄漏，没有delloc",owner,varName);
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), self.ht_dellocBlock);
}

- (void)ht_willDealloc{
    NSString *objName = NSStringFromClass([self class]);
    self.ht_dellocBlock = dispatch_block_create(0, ^{
        NSLog(@"%@ 可能存在内存泄漏，没有delloc",objName);
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), self.ht_dellocBlock);
}

- (void)ht_dealloc{
    if (self.ht_dellocBlock){
        dispatch_block_cancel(self.ht_dellocBlock);
    }
    [self ht_dealloc];
}

- (void)setHt_dellocBlock:(dispatch_block_t)ht_dellocBlock{
    objc_setAssociatedObject(self, ht_dellocBlockey, ht_dellocBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (dispatch_block_t)ht_dellocBlock{
    return objc_getAssociatedObject(self, ht_dellocBlockey);
}


- (void)ht_allVarsWillDealloc{
    Class cls = [self class];
    NSString *owner = NSStringFromClass([self class]);
    unsigned int ivarsCnt = 0;
    Ivar *ivars = class_copyIvarList(cls, &ivarsCnt);
    for (const Ivar *p = ivars; p < ivars + ivarsCnt; ++p)
    {
        Ivar const ivar = *p;
        
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        id obj =  object_getIvar(self,ivar);
        [obj ht_willDeallocWithOwner:owner ivar:name];
        
    }
}

@end

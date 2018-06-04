//
//  UIViewController+HTMethodMonitor.h
//  PutPoints
//
//  Created by iMac on 2017/11/26.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HTMethodMonitor)

@property (nonatomic, strong)NSNumber    *didLoadTime;

@property (nonatomic, copy)dispatch_block_t  ht_dellocBlock;

- (void)ht_ViewDidLoad;
- (void)ht_viewWillAppear:(BOOL)animated;
- (void)ht_viewDidAppear:(BOOL)animated;
- (void)ht_viewWillDisappear:(BOOL)animated;
- (void)ht_viewDidDisappear:(BOOL)animated;
//- (void)ht_willDealloc;
//- (void)ht_dealloc;

@end

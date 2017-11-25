//
//  ViewController.m
//  SmoothMoniter
//
//  Created by iMac0 on 2017/4/18.
//  Copyright © 2017年 iMac0. All rights reserved.
//

#import "ViewController.h"
#import "SmoothMoniter.h"
#import "CPUMonitor.h"

@interface ViewController ()

@property (nonatomic, strong)CADisplayLink    *displayLink;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[CPUMonitor sharedInstance] start];
//    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTextColor)];
//    self.displayLink.paused = YES;
//    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
//    self.displayLink.paused = NO;
    

//    [[SmoothMoniter sharedInstance] startMoniter];
}

- (void)updateTextColor{
    NSLog(@"updafe");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

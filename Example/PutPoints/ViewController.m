//
//  ViewController.m
//  PutPoints
//
//  Created by iMac on 2017/11/26.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "HTMonitor.h"
#import "HTFPSMonitor.h"

@interface ViewController ()


@property (nonatomic, copy) NSMutableArray *mutableArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(100, 200, 50, 50);
    [btn addTarget:self action:@selector(btnClicked_toPush) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [HTMonitor startMonitor:HTMonitorTypeFPS];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HTMonitor stopMonitor:HTMonitorTypeFPS];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HTMonitor startMonitor:HTMonitorTypeFPS];
    });
    
    
//    [HTMonitor startMonitorType:HTMonitorTypeAll];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch======");
}




- (void)btnClicked_toPush{
    SecondViewController *sec = [[SecondViewController alloc]init];
    sec.title = @"sec";
    [self.navigationController pushViewController:sec animated:NO];
}

- (void)btnClicked_toPresent{
    SecondViewController *sec = [[SecondViewController alloc]init];
    sec.title = @"sec";
    [self presentViewController:sec animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

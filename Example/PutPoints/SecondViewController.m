//
//  SecondViewController.m
//  PutPoints
//
//  Created by iMac on 2017/11/26.
//  Copyright © 2017年 iMac. All rights reserved.
//

#import "SecondViewController.h"
#import "ViewController.h"
#import "HTMonitor.h"

typedef void(^HTBlock)(NSString *msg);

@interface SecondViewController ()

@property (nonatomic, copy)HTBlock  block;

@end

@implementation SecondViewController 
    
    

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];

//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    btn.frame = CGRectMake(100, 200, 50, 50);
//    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//
    UILabel *label = [[UILabel alloc]init];
    
    // 测试循环引用block
    self.block = ^(NSString *msg){
        label.text = @"OK";
        self.view.backgroundColor = [UIColor orangeColor];
    };
    self.block(@"abc");
    
//    [HTMonitor stopMonitor:HTMonitorTypeAll];
}

- (void)btnClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

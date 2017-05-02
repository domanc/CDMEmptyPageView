//
//  ViewController.m
//  CDMEmptyPageView
//
//  Created by Doman on 2017/5/2.
//  Copyright © 2017年 Doman. All rights reserved.
//

#import "ViewController.h"
#import "UIView+CDMEmpty.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 网络错误时,展示错误页
    [self.view showNetErrorPageView];
    [self.view configReloadAction:^{
        
        NSLog(@"刷新");
    }];
    //隐藏网络错误页
    //  [self.view hideNetErrorPageView];
    
    //
    //    //无数据展示空白页
    //    [self.view showBlankPageView];
    //    //无数据隐藏空白页
    //    [self.view hideBlankPageView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

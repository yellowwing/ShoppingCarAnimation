//
//  YWMainViewController.m
//  YueSheng
//
//  Created by yellow on 16/7/15.
//  Copyright © 2016年 yellow. All rights reserved.
//

#import "YWMainViewController.h"
#import "YWTabBarController.h"

@interface YWMainViewController ()


@end

@implementation YWMainViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置文字颜色
//    self.navBar.navBarTintColor = [UIColor whiteColor];
    
    //设置bar背景色
    self.navBar.navBarColor = [UIColor orangeColor];
    
    //写这一句适配iOS11以下的
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //这个app要隐藏line
//    self.navBar.line.hidden = YES;
    self.navBar.line.alpha = 0.1;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}




@end

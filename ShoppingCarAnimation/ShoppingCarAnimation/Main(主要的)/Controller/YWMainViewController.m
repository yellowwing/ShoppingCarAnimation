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
//懒加载meStatus
-(YWMeStatus *)meStatus{
    //从本地加载meStatus
    _meStatus = [NSKeyedUnarchiver unarchiveObjectWithFile:YWMepath];
    
    return _meStatus;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    //左边返回按钮不显示文字
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] init];
//    barButtonItem.title = @"";
//    self.navigationItem.backBarButtonItem = barButtonItem;
    
//    self.navigationItem.titleView = titleView;
    
    //titleView是投资快报
//    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
//
#warning - 高度太大了，标题小一点弄个24或26，iPhoneX才能好看
//    titleView.bounds = CGRectMake(0, 0, 100, 30);
//
//    self.navBar.titleView = titleView;
    
    //设置文字颜色
//    self.navBar.navBarTintColor = [UIColor whiteColor];
    
    //设置bar背景色
    self.navBar.navBarColor = mainColor;
    
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

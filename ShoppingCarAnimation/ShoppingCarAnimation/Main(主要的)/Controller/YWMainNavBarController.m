//
//  ViewController.m
//  navBar分隔效果测试
//
//  Created by yellow on 2017/11/22.
//  Copyright © 2017年 TZKB. All rights reserved.
//

#import "YWMainNavBarController.h"

#import "YWMainNavBar.h"


#define kDevice_Is_iPhoneX (([[UIApplication sharedApplication] statusBarFrame].size.height == 44.0f) ? (YES):(NO))

@interface YWMainNavBarController ()

@end

@implementation YWMainNavBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self setupNavBar];
    

}


-(void)setupNavBar{
    
    CGFloat barHeight;
    if (kDevice_Is_iPhoneX) {
        barHeight = 88;
    }
    else{
        barHeight = 64;
        
    }
    
    YWMainNavBar *bar = [[YWMainNavBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, barHeight)];
    
    self.navBar = bar;
    
    [self.view addSubview:bar];
    
    if (self.navigationController.viewControllers.count > 1) {
        UIButton *backBtn = [[UIButton alloc] init];
        [backBtn setImage:[UIImage imageNamed:@"goback"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"goback"] forState:UIControlStateHighlighted];
        backBtn.bounds = CGRectMake(0, 0, 28, 30);
        bar.leftItem = backBtn;
        [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
 

}

-(void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



@end

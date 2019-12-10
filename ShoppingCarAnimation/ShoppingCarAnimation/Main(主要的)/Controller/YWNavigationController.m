//
//  YWNavigationController.m
//  通信录
//
//  Created by yellow on 16/6/28.
//  Copyright © 2016年 yellow. All rights reserved.
//

#import "YWNavigationController.h"

@interface YWNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation YWNavigationController




-(void)viewDidLoad{
    [super viewDidLoad];
    
    
}



//重写pushViewController(用storyboard的话这个方法不适用)
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //push的时候隐藏tabbar
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
}




@end

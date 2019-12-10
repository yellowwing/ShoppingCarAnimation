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

////系统在第一次使用这个类的时候调用
//+(void)initialize{
//
//    //1.设置导航栏主题
//    [self setupNavBarTheme];
//
//    //2.设置导航栏按钮主题
//    [self setupBarButtonItemTheme];
//
//
//}



-(void)viewDidLoad{
    [super viewDidLoad];
    
//    //全局手势优化返回上一级控制器
//    id target = self.interactivePopGestureRecognizer.delegate;
//
//    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];
//    self.pan = pan;
//    // 设置手势代理，拦截手势触发
//    pan.delegate = self;
//
//
//    // 给导航控制器的view添加全屏滑动手势
//    [self.interactivePopGestureRecognizer.view addGestureRecognizer:pan];
//
//    // 禁止使用系统自带的滑动手势
//    self.interactivePopGestureRecognizer.enabled = NO;
    
}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//
//    if (self.viewControllers.count > 1) {
//        return YES;
//    }
//
//    return NO;
//}

//重写pushViewController(用storyboard的话这个方法不适用)
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //push的时候隐藏tabbar
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
}

////1.设置导航栏主题
//+(void)setupNavBarTheme{
//    UINavigationBar *navBar = [UINavigationBar appearance];
//    [navBar setBarTintColor:mainColor];
//    [navBar setTintColor:[UIColor whiteColor]];
//
//    //设置标题属性
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
//    [navBar setTitleTextAttributes:textAttrs];
//
//    //取消模糊效果防止色差
//    navBar.translucent = NO;
//
//}
//
////2.设置导航栏按钮主题
//+(void)setupBarButtonItemTheme{
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
//    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//
//}
//
////重写pushViewController(用storyboard的话这个方法不适用)
//-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//
//    //左边返回按钮不显示文字
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] init];
//    barButtonItem.title = @"";
//    viewController.navigationItem.backBarButtonItem = barButtonItem;
//
//    //push的时候隐藏tabbar
//    if (self.viewControllers.count > 0) {
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
//    [super pushViewController:viewController animated:animated];
//}



@end

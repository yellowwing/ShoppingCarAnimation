//
//  YWTabBarController.m
//  通信录
//
//  Created by yellow on 16/6/29.
//  Copyright © 2016年 yellow. All rights reserved.
//

#import "YWTabBarController.h"


#import "YWNavigationController.h"
#import "YWMainViewController.h"

#import "YWHomeController.h"


@interface YWTabBarController ()<UITabBarDelegate>



//首页
@property (nonatomic, strong) YWMainViewController *homeVC;

//已选
@property (nonatomic, strong) YWMainViewController *selectedVC;

//我的
@property (nonatomic, strong) YWMainViewController *meVC;

@end

@implementation YWTabBarController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = [UIColor orangeColor];
    self.tabBar.translucent = NO;
    [[UITabBar appearance] setBarTintColor: [UIColor whiteColor]];
    
    
    //初始化所有子控制器
    [self setupAllChildViewControllers];
    
    
}


//销毁的时候调用
- (void)dealloc{
    
    //注销通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

}


-(void)setupAllChildViewControllers{
    
    YWHomeController *homeVC = [[YWHomeController alloc] initWithNibName:@"YWHomeController" bundle:nil];
    [self setupChildViewController:homeVC title:@"" imageName:@"2首页01"  selectedImageName:@"2首页02"];
    self.homeVC = homeVC;


    YWMainViewController *selectedVC = [[YWMainViewController alloc] init];
    [self setupChildViewController:selectedVC title:@"" imageName:@"2超市01" selectedImageName:@"2超市02"];
    self.selectedVC = selectedVC;


    YWMainViewController *meVC = [[YWMainViewController alloc] init];
    [self setupChildViewController:meVC title:@"" imageName:@"2我01" selectedImageName:@"2我02"];
    self.meVC = meVC;
    
//     self.meVC.navigationController.tabBarItem.badgeValue = @"1";

}



-(void)setupChildViewController:(UIViewController*)childVc title:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName{
    
    //1.
    childVc.title = title;
    childVc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //改变图片位置
//    [childVc.tabBarItem setImageInsets:UIEdgeInsetsMake(-2, 0, 2, 0)];
    
    //改变文字大小位置
//    [childVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    //Normal
    [childVc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} forState:UIControlStateNormal];
    
    //Selected
    [childVc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]} forState:UIControlStateSelected];
    
    //2.
    YWNavigationController *nav= [[YWNavigationController alloc] initWithRootViewController:childVc];
    
    if ([childVc.tabBarItem.title isEqualToString:@"我的"]) {
        nav.view.backgroundColor = [UIColor whiteColor];
    }
    
    [self addChildViewController:nav];
    
    
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{

    
}




@end

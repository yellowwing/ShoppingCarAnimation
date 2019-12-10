//
//  YWTabBarController.m
//  通信录
//
//  Created by yellow on 16/6/29.
//  Copyright © 2016年 yellow. All rights reserved.
//

#import "YWTabBarController.h"


#import "YWNavigationController.h"



@interface YWTabBarController ()<UITabBarDelegate>


//首页
@property (nonatomic, strong) UIViewController *homeVC;

//已选
@property (nonatomic, strong) UIViewController *selectedVC;

//我的
@property (nonatomic, strong) UIViewController *meVC;

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
    
    UIViewController *homeVC = [[UIViewController alloc] init];
    [self setupChildViewController:homeVC title:@"首页" imageName:@"home"  selectedImageName:@"homeSelected"];
    self.homeVC = homeVC;


    UIViewController *selectedVC = [[UIViewController alloc] init];
    [self setupChildViewController:selectedVC title:@"已选" imageName:@"selected" selectedImageName:@"selectedSelected"];
    self.selectedVC = selectedVC;


    UIViewController *meVC = [[UIViewController alloc] init];
    [self setupChildViewController:meVC title:@"我的" imageName:@"me" selectedImageName:@"meSelected"];
    self.meVC = meVC;
    
    

}



-(void)setupChildViewController:(UIViewController*)childVc title:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName{
    
    //1.
    childVc.title = title;
    childVc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //改变图片位置
    [childVc.tabBarItem setImageInsets:UIEdgeInsetsMake(-2, 0, 2, 0)];
    
    //改变文字大小位置
    [childVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
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

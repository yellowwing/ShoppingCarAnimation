//
//  YWTabBarController.m
//  通信录
//
//  Created by yellow on 16/6/29.
//  Copyright © 2016年 yellow. All rights reserved.
//

#import "YWTabBarController.h"


#import "YWNavigationController.h"

#import "YWMeStatus.h"
#import "YWHomeController.h"
#import "YWSelectedController.h"
#import "YWMeController.h"


@interface YWTabBarController ()<UITabBarDelegate>

@property(nonatomic,strong)YWMeStatus *meStatus;

//首页
@property (nonatomic, strong) YWHomeController *homeVC;

//已选
@property (nonatomic, strong) YWSelectedController *selectedVC;

//我的
@property (nonatomic, strong) YWMeController *meVC;

@end

@implementation YWTabBarController


//为了适配iOS11，无法使用自定义tabBar，用系统的

//要注意的是：当你改了模型记得把它保存到本地
//懒加载meStatus
-(YWMeStatus *)meStatus{
    //从本地加载meStatus
    _meStatus = [NSKeyedUnarchiver unarchiveObjectWithFile:YWMepath];
    
    return _meStatus;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = mainColor;
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
    [self setupChildViewController:homeVC title:@"首页" imageName:@"home"  selectedImageName:@"homeSelected"];
    self.homeVC = homeVC;


    YWSelectedController *selectedVC = [[YWSelectedController alloc] initWithNibName:@"YWSelectedController" bundle:nil];
    [self setupChildViewController:selectedVC title:@"已选" imageName:@"selected" selectedImageName:@"selectedSelected"];
    self.selectedVC = selectedVC;


    YWMeController *meVC = [[YWMeController alloc] initWithNibName:@"YWMeController" bundle:nil];
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

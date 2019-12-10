//
//  MyTabBar.h
//  DaSheHui
//
//  Created by Wing on 15-9-25.
//  Copyright (c) 2015年 yellow-wing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyTabBar;

@class MyTabBarButton;
@protocol MyTabBarDelegate <NSObject>

@optional
- (void)tabBar:(MyTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;

@end


@interface MyTabBar : UIView

- (void)buttonClick:(MyTabBarButton *)button;
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property(nonatomic,weak)id<MyTabBarDelegate> delegate;

@property(nonatomic,strong)NSMutableArray *barItemArr;
@end

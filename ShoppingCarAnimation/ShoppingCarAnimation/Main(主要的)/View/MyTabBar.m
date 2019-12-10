//
//  MyTabBar.m
//  DaSheHui
//
//  Created by Wing on 15-9-25.
//  Copyright (c) 2015年 yellow-wing. All rights reserved.
//

#import "MyTabBar.h"
#import "MyTabBarButton.h"
#import "UIImage+YW.h"

@interface MyTabBar ()

@property(nonatomic,weak)MyTabBarButton *selectButton;



@end

@implementation MyTabBar

- (NSMutableArray *)barItemArr{
    if (_barItemArr == nil) {
        _barItemArr = [NSMutableArray array];
    }
    return _barItemArr;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item{
    //创建按钮
    MyTabBarButton *button = [[MyTabBarButton alloc] init];
    [self addSubview:button];
    
    button.item = item;
    
    //监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self.barItemArr addObject:button];
    
    //默认选中首页
    if (self.barItemArr.count == 1) {
        [self buttonClick:button];
    }
}

- (void)buttonClick:(MyTabBarButton *)button{
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectButton.tag to:button.tag];
    }

   //原先选中的取消选中
    self.selectButton.selected = NO;
    //点击的按钮设置为选中状态
    button.selected = YES;
    //将该按钮设置赋值给self.selectButton;
    self.selectButton = button;

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat viewH = self.frame.size.height;
    CGFloat viewW = self.frame.size.width;
    
    
    // 按钮的frame数据
    CGFloat buttonH = viewH;
    CGFloat buttonW = viewW / self.subviews.count;
    CGFloat buttonY = 0;
    
    for (int index = 0; index<self.barItemArr.count; index++) {
        // 1.取出按钮
        MyTabBarButton *button = self.barItemArr[index];
        
        // 2.设置按钮的frame
        CGFloat buttonX = index * buttonW;
  
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 3.绑定tag
        button.tag = index;
    }
}


@end

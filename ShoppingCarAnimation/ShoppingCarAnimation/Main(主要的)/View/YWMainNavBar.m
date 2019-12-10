//
//  YWMainNavBar.m
//  navBar分隔效果测试
//
//  Created by yellow on 2017/11/25.
//  Copyright © 2017年 TZKB. All rights reserved.
//

#import "YWMainNavBar.h"

#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

@implementation YWMainNavBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //创建控件
       UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
        CGFloat lineX = 0;
        CGFloat lineH = 0.5;
        CGFloat lineY = frame.size.height - lineH;
        CGFloat lineW = frame.size.width;
        line.frame = CGRectMake(lineX ,lineY , lineW, lineH);
        [self addSubview:line];
        self.line = line;
        
        //初始化属性
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

-(void)setNavBarHidden:(BOOL)navBarHidden{
    
    _navBarHidden = navBarHidden;
    
    self.hidden = navBarHidden;
    
}

//先不做这效果了
//-(void)setIsNeedGradientLayer:(BOOL)isNeedGradientLayer{
//
//    _isNeedGradientLayer = isNeedGradientLayer;
//
//    if (isNeedGradientLayer) {
//
//        self.backgroundColor = [UIColor clearColor];
//    }
//    else{
//
//
//        self.backgroundColor = self.navBarColor;
//    }
//
//}

-(void)setNavBarAlpha:(CGFloat)navBarAlpha{
    
    _navBarAlpha = navBarAlpha;
    
    self.alpha = navBarAlpha;
}

//-(void)setNavBarTintColor:(UIColor *)navBarTintColor{
//
//    _navBarTintColor = navBarTintColor;
//
//    for (UIView *view in self.subviews) {
//        if ([view isKindOfClass:[UIButton class]]) {
//            UIButton *button = (UIButton*)view;
//            [button setTitleColor:navBarTintColor forState:UIControlStateNormal];
//        }
//        if ([view isKindOfClass:[UILabel class]]) {
//            UILabel *label = (UILabel *)view;
//            label.textColor = navBarTintColor;
//        }
//    }
//
//}

-(void)setNavBarColor:(UIColor *)navBarColor{
    
    _navBarColor = navBarColor;
    
    self.backgroundColor = navBarColor;
    
}

-(void)setLeftItem:(UIView *)leftItem{
    
    
    if (_leftItem != nil) {
        [_leftItem removeFromSuperview];
    }
    
    _leftItem = leftItem;
    
    CGFloat statusBarH;
    if (kDevice_Is_iPhoneX) {
        statusBarH = 44;
    }
    else{
        statusBarH = 20;
        
    }
    CGFloat centerX = 5 + leftItem.bounds.size.width/2;
    CGFloat barH = 44;
    CGFloat centerY = statusBarH + barH/2;
    leftItem.center = CGPointMake(centerX, centerY);
    
    [self addSubview:leftItem];
    
//    self.navBarTintColor = self.navBarTintColor;
   
}

-(void)setRightItem:(UIView *)rightItem{
    
    if (_rightItem != nil) {
        [_rightItem removeFromSuperview];
    }
    
    _rightItem = rightItem;
    
    CGFloat statusBarH;
    if (kDevice_Is_iPhoneX) {
        statusBarH = 44;
    }
    else{
        statusBarH = 20;
        
    }
    
    CGFloat centerX = self.frame.size.width - rightItem.bounds.size.width/2 - 5;
    CGFloat barH = 44;
    CGFloat centerY = statusBarH + barH/2;
    rightItem.center = CGPointMake(centerX, centerY);
    
    [self addSubview:rightItem];
    
//    self.navBarTintColor = self.navBarTintColor;
    
}

-(void)setTitleView:(UIView *)titleView{
    
    if (_titleView != nil) {
        [_titleView removeFromSuperview];
    }
    
    _titleView = titleView;
    
    
    CGFloat statusBarH;
    if (kDevice_Is_iPhoneX) {
        statusBarH = 44;
    }
    else{
        statusBarH = 20;
        
    }
    
    CGFloat centerX = self.frame.size.width/2;
    CGFloat barH = 44;
    CGFloat centerY = statusBarH + barH/2;
    titleView.center = CGPointMake(centerX, centerY);
    
    [self addSubview:titleView];
    
//    self.navBarTintColor = self.navBarTintColor;
}



-(void)setTitle:(NSString *)title{
    
    _title = [title copy];
    
    UILabel *titleView = [[UILabel alloc] init];
    
    titleView.bounds = CGRectMake(0, 0, 150, 26);
    
    titleView.font = [UIFont systemFontOfSize:17];
    
    titleView.textColor = [UIColor whiteColor];
    
    titleView.text = title;
    
    titleView.textAlignment = NSTextAlignmentCenter;
    
    self.titleView = titleView;
}


@end

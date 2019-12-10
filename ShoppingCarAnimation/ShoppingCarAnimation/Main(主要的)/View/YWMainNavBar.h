//
//  YWMainNavBar.h
//  navBar分隔效果测试
//
//  Created by yellow on 2017/11/25.
//  Copyright © 2017年 TZKB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWMainNavBar : UIView

@property(nonatomic,assign)BOOL navBarHidden;

@property(nonatomic,assign)CGFloat navBarAlpha;

//@property(nonatomic,strong)UIColor *navBarTintColor;

@property(nonatomic,strong)UIColor *navBarColor;


//位置是里面决定（center），大小是外面决定（bounds.size）
@property(nonatomic,weak)UIView *leftItem;

@property(nonatomic,weak)UIView *titleView;

@property(nonatomic,weak)UIView *rightItem;

@property(nonatomic,weak)UIView *line;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,assign)BOOL isNeedGradientLayer;


@end

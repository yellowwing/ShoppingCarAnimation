//
//  MyTabBarButton.m
//  DaSheHui
//
//  Created by Wing on 15-9-25.
//  Copyright (c) 2015年 yellow-wing. All rights reserved.
//

#import "MyTabBarButton.h"

#import "IWBadgeButton.h"
// 图标的比例
#define MyTabBarButtonImageRatio 0.6

// 按钮的默认文字颜色
#define  MyTabBarButtonTitleColor [UIColor lightGrayColor]

// 按钮的选中文字颜色
#define  MyTabBarButtonTitleSelectedColor mainColor

@interface MyTabBarButton()
/**
 *  提醒数字
 */
@property (nonatomic, weak) IWBadgeButton *badgeButton;
@end

@implementation MyTabBarButton

//假如是代码创建的
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        
        //文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        //字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        
        //文字颜色
        [self setTitleColor:MyTabBarButtonTitleColor forState:UIControlStateNormal];
        [self setTitleColor:MyTabBarButtonTitleSelectedColor forState:UIControlStateSelected];

        
        // 添加一个提醒数字按钮
        IWBadgeButton *badgeButton = [[IWBadgeButton alloc] init];
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
    }

    return self;
}

//假如是xib创建的
-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    if (self = [super initWithCoder:aDecoder]) {
        
        //图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        
        //文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        //字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        
        //文字颜色
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//        [self setTitleColor:MyTabBarButtonTitleSelectedColor forState:UIControlStateSelected];
        
        
        // 添加一个提醒数字按钮
//        IWBadgeButton *badgeButton = [[IWBadgeButton alloc] init];
//        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
//        [self addSubview:badgeButton];
//        self.badgeButton = badgeButton;
        
    }
    return self;

}

//重写取消高亮
- (void)setHighlighted:(BOOL)highlighted{}

//设置内部图片frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * MyTabBarButtonImageRatio;
    return CGRectMake(0, 5, imageW, imageH-5);
}
//设置内部文字frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = contentRect.size.height * MyTabBarButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

// 设置item
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    // KVO 监听属性改变
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}

/**
 *  监听到某个对象的属性改变了,就会调用
 *
 *  @param keyPath 属性名
 *  @param object  哪个对象的属性被改变
 *  @param change  属性发生的改变
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 设置文字
    [self setTitle:self.item.title forState:UIControlStateSelected];
    [self setTitle:self.item.title forState:UIControlStateNormal];
    
    // 设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    // 设置提醒数字
    self.badgeButton.badgeValue = self.item.badgeValue;
    
    // 设置提醒数字的位置
    CGFloat badgeY = 5;
    CGFloat badgeX = self.frame.size.width - self.badgeButton.frame.size.width - 30;
    CGRect badgeF = self.badgeButton.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.badgeButton.frame = badgeF;
}

@end

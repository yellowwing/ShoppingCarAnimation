//
//  YWHomeController.m
//  ShoppingCarAnimation
//
//  Created by yellow on 2019/12/10.
//  Copyright © 2019 YW. All rights reserved.
//

#import "YWHomeController.h"
#import "YWTgStatus.h"
#import "YWTgCell.h"
#import "HomeHeaderView.h"

@interface YWHomeController ()<UITableViewDelegate,UITableViewDataSource,YWTgCellDelegate,CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *barConstraintHeight;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *imageViews;

@property (nonatomic, strong) NSArray *tgs;

@property(nonatomic,assign)BOOL isBezierPathAnimation;

@end

@implementation YWHomeController

#warning - 贝塞尔曲线☑️、简书、简历2份

#warning - 另外2份项目：建github、创建项目、抄、简书、简历2份

-(NSMutableArray*)imageViews{

    if (_imageViews == nil) {
        _imageViews = [NSMutableArray array];
    }
    return _imageViews;
}


/**
 *  数据的懒加载
 */
- (NSArray *)tgs
{
    if (_tgs == nil) {
        // 初始化
        // 1.获得plist的全路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"tgs.plist" ofType:nil];
        
        // 2.加载数组
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        // 3.将dictArray里面的所有字典转成模型对象,放到新的数组中
        NSMutableArray *tgArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            // 3.1.创建模型对象
            YWTgStatus *tg = [YWTgStatus tgWithDict:dict];
            
            // 3.2.添加模型对象到数组中
            [tgArray addObject:tg];
        }
        
        // 4.赋值
        _tgs = tgArray;
    }
    return _tgs;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.barConstraintHeight.constant = self.navBar.frame.size.height;
    
    self.navBar.title = @"首页";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.rowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    HomeHeaderView *header = [HomeHeaderView headerView];
    
    self.tableView.tableHeaderView = header;
    
    [self setupRightItem];
}

-(void)setupRightItem{
    
    UIButton *editBtn = [[UIButton alloc] init];
    [editBtn setTitle:@"切换动画" forState:UIControlStateNormal];
    editBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    editBtn.bounds = CGRectMake(0, 0, 120, 44);
    editBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

//        [editBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 13)];
        [editBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)];
    self.navBar.rightItem = editBtn;
    [editBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
}

-(void)edit{
    
    if (self.isBezierPathAnimation) {
        
        //转为组合动画
        self.isBezierPathAnimation = NO;
        
    }
    else{
        
        //转为贝塞尔曲线动画
        self.isBezierPathAnimation = YES;
        
    }
}

-(void)badgeValueInstance{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger badge = [defaults integerForKey:@"badge"];
    
    badge = 0;
    
    [defaults setInteger:badge forKey:@"badge"];
    
    [defaults synchronize];
}

#pragma mark - 数据源方法
/**
 *  一共有多少行数据
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tgs.count;
}

/**
 *  每一行显示怎样的cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    YWTgCell *cell = [YWTgCell cellWithTableView:tableView];
    
    cell.delegate = self;
    
    // 2.给cell传递模型数据
    cell.tg = self.tgs[indexPath.row];
    return cell;
}

-(void)berzierAnimationWithCell:(UITableViewCell*)cell andIconView:(UIImageView *)iconView{
    
    #pragma mark - 转换父控件所在位置
        CGRect rects = [cell.contentView convertRect:iconView.frame toView:self.view];

        //    NSLog(@"我是位置：%@",NSStringFromCGRect(rects));
            
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.layer.cornerRadius = 5;
            [self.view.window addSubview:imageView];
            imageView.frame = rects;
            imageView.image = iconView.image;
            //用数组装着imageView,等动画结束就销毁imageView
            [self.imageViews addObject:imageView];
    

    CGFloat Wi = [UIScreen mainScreen].bounds.size.width;
    CGFloat He = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat desX = Wi/3*2 + Wi/3/2 + 25;
    CGFloat desY = He - 40;
    
    CGPoint startPoint = CGPointMake(rects.origin.x+rects.size.width/2, rects.origin.y+rects.size.height/2);
    
    CGPoint endpoint = CGPointMake(desX, desY);
    
    //控制曲线幅度的点
    CGPoint controlPoint = CGPointMake(endpoint.x-100, startPoint.y-300);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addQuadCurveToPoint:endpoint controlPoint:controlPoint];
    
    
    //创建关键帧
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    animation.path = path.CGPath;
    
    
    // 2.创建缩放动画对象
    CABasicAnimation *scale = [CABasicAnimation animation];
    scale.keyPath = @"transform.scale";
    scale.toValue = @(0.1);
    

    // 4.将所有的动画添加到动画组中
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation, scale];
    
    group.duration = 1;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.delegate = self;
    
    //当动画完成，停留到结束位置
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    
    [imageView.layer addAnimation:group forKey:nil];
    
    path = nil;
    
}

-(void)groupAnimationWithCell:(UITableViewCell*)cell andIconView:(UIImageView *)iconView{

    #pragma mark - 转换父控件所在位置
        CGRect rects = [cell.contentView convertRect:iconView.frame toView:self.view];
        
    //    NSLog(@"我是位置：%@",NSStringFromCGRect(rects));
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = 5;
        [self.view.window addSubview:imageView];
        imageView.frame = rects;
        imageView.image = iconView.image;
        //用数组装着imageView,等动画结束就销毁imageView
        [self.imageViews addObject:imageView];
        
    #pragma mark - 加入购物车的动画
        // 1.创建旋转动画对象
        CABasicAnimation *rotate = [CABasicAnimation animation];
        rotate.keyPath = @"transform.rotation";
        rotate.toValue = @(4 * M_PI);
        
        
        // 2.创建缩放动画对象
        CABasicAnimation *scale = [CABasicAnimation animation];
        scale.keyPath = @"transform.scale";
        scale.toValue = @(0.0);
        
        // 3.平移动画
        CABasicAnimation *move = [CABasicAnimation animation];
        move.keyPath = @"transform.translation";
        
       //toValue不能写死，它是相对于做动画的控件的point而言的，所以要做一些计算
        
        CGFloat Wi = [UIScreen mainScreen].bounds.size.width;
        CGFloat He = [UIScreen mainScreen].bounds.size.height;
        
        CGFloat desX = Wi - 80;
        CGFloat desY = He - 80;
        
        CGFloat moveY = desY - rects.origin.y;
        CGFloat moveX = desX - rects.origin.x;
        
        move.toValue = [NSValue valueWithCGPoint:CGPointMake(moveX, moveY)];
        
        // 4.将所有的动画添加到动画组中
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.animations = @[rotate, scale, move];
        group.duration = 1;
        group.delegate = self;
        group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        
    //    下面两句是保持动画执行完毕后的状态
        group.removedOnCompletion = NO;
        group.fillMode = kCAFillModeForwards;
        
        [imageView.layer addAnimation:group forKey:nil];
        
}


-(void)tgCell:(YWTgCell *)cell didClickBuyWithImageView:(UIImageView *)iconView{

    if (self.isBezierPathAnimation) {
        //贝塞尔曲线动画
        [self berzierAnimationWithCell:cell andIconView:iconView];
    }
    else{
        //组合动画
        [self groupAnimationWithCell:cell andIconView:iconView];
        
    }
    
}

#pragma mark - 动画的代理方法
-(void)animationDidStart:(CAAnimation *)anim{

}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

   // 等动画结束就销毁第一个imageView，这样不会占内存了
   UIImageView *imageView = [self.imageViews firstObject];
    [imageView removeFromSuperview];
    [self.imageViews removeObject:imageView];
    
    NSLog(@"==%lu ==%lu",(unsigned long)self.view.window.subviews.count,(unsigned long)self.imageViews.count);
    
    
#pragma mark - 让badgeValue＋1
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger badge = [defaults integerForKey:@"badge"];
    
    badge++;
    
    [defaults setInteger:badge forKey:@"badge"];
    
    [defaults synchronize];
    
    NSString *badgeValue = [NSString stringWithFormat:@"%ld",badge];
    
    //下面的方法都不行，只能发送通知叫tabBarController去增加了
    NSNotification *notification=[NSNotification notificationWithName:@"badgeNotification" object:self userInfo:@{@"context":badgeValue}];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    

}


@end

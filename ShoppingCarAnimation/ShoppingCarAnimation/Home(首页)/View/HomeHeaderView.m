//
//  HomeHeaderView.m
//  通信录
//
//  Created by yellow on 16/7/2.
//  Copyright © 2016年 yellow. All rights reserved.
//

#import "HomeHeaderView.h"
#import "YWImageCell.h"
#import "MJExtension.h"
#import "YWAdStatus.h"

#define YWCellID @"cell"

// 每一组最大的行数
//#define YWadsTotalRowsInSection (5000 * self.newses.count)
//#define YWadsDefaultRow (NSUInteger)(MJNewsTotalRowsInSection * 0.5)

#define maxSections 100

@interface HomeHeaderView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControll;
@property (nonatomic,strong)NSTimer *timer;

@property(nonatomic,strong)NSArray *ads;

@end

@implementation HomeHeaderView
+(instancetype)headerView{
    
    return [[NSBundle mainBundle] loadNibNamed:@"HomeHeaderView" owner:nil options:nil].lastObject;
    
}


-(NSArray*)ads{
    if (_ads == nil) {
        _ads = [YWAdStatus objectArrayWithFilename:@"newses.plist"];
        self.pageControll.numberOfPages = _ads.count;
    }
    return _ads;
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    self.collectionView.delegate = self;
    
    self.collectionView.dataSource = self;

    //秘诀1.在awakeFromNib拿出collectionView重新计算frame，并且宽度是屏幕宽度
    //秘诀2.重新定义每个UICollectionViewCell的大小，宽度也是屏幕宽度
    //秘诀3.里面的imageView的autoresizing全部选中
    self.collectionView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.collectionView.frame.size.height);
    
    //注册cell(xib创建用前者，代码创建用后者)
     [self.collectionView registerNib:[UINib nibWithNibName:@"YWImageCell" bundle:nil] forCellWithReuseIdentifier:YWCellID];
//    [self.collectionView registerClass:[YWImageCell class] forCellWithReuseIdentifier:YWCellID];
    
    //默认显示中间那组
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:maxSections/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    //添加定时器
    [self addTimer];
    
    //添加pageController
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.ads.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

  YWImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YWCellID forIndexPath:indexPath];
    
    cell.status = self.ads[indexPath.item];
    
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return maxSections;
}

//添加定时器
-(void)addTimer{

   NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

//移除定时器
-(void)removeTimer{

    [self.timer invalidate];
    
    self.timer = nil;

}

//调用下一页方法
-(void)nextPage{

    NSIndexPath *currentIndexPathReset = [self resetIndexPath];
    
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    
    if (nextItem == self.ads.count) {
        nextItem = 0;
        nextSection++;
    }
    
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    self.pageControll.currentPage = nextItem;
    
}


//定义每个UICollectionViewCell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 200);
    
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [self removeTimer];
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.ads.count;
    
    self.pageControll.currentPage = page;

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
//    [self resetIndexPath];
    
    
    [self addTimer];
    
}

//重置indexPath，这样永远都滚不完
-(NSIndexPath *)resetIndexPath{

NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];

NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:maxSections/2];

[self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    return currentIndexPathReset;
}



@end

//
//  YWTgCell.m
//  通信录
//
//  Created by yellow on 16/7/2.
//  Copyright © 2016年 yellow. All rights reserved.
//

#import "YWTgCell.h"
#import "YWTgStatus.h"
@interface YWTgCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

- (IBAction)buttonClick;

@end

@implementation YWTgCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"tg";
    YWTgCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
#pragma mark - 因为这不是从storyboard加载cell，而是从xib加载cell，所以下面代码也是需要的
    if (cell == nil) {
        // 从xib中加载cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YWTgCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
- (void)setTg:(YWTgStatus *)tg
{
    _tg = tg;
    
    // 1.图片
    self.iconView.image = [UIImage imageNamed:tg.icon];
    
    // 2.标题
    self.nameLabel.text = tg.title;
    
    // 3.价格
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", tg.price];
    
    // 4.购买数
    self.buyCountLabel.text = [NSString stringWithFormat:@"%@人已购买", tg.buyCount];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.buyBtn.layer.cornerRadius = 5;
    self.iconView.layer.cornerRadius = 5;
    self.iconView.clipsToBounds = YES;
    
}

-(void)setFrame:(CGRect)frame{

    CGFloat hPadding = 8;
    CGFloat wPadding = 10;
    frame.origin.y += hPadding;
    frame.size.height -= hPadding;
    frame.origin.x += wPadding;
    frame.size.width -= 2*wPadding;
    [super setFrame:frame];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
   
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{

}

- (IBAction)buttonClick {
    
    //将imageView通过代理传给controller
    
    //controller用位置转换方法[cell.contentView convertRect:imageview.frame toView:self.view];
    
    if ([self.delegate respondsToSelector:@selector(tgCell:didClickBuyWithImageView:)]) {
        [self.delegate tgCell:self didClickBuyWithImageView:self.iconView];
    }
    
}
@end

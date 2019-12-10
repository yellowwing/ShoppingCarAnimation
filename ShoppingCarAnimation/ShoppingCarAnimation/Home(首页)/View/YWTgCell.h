//
//  YWTgCell.h
//  通信录
//
//  Created by yellow on 16/7/2.
//  Copyright © 2016年 yellow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YWTgStatus,YWTgCell;

@protocol YWTgCellDelegate <NSObject>

@optional
-(void)tgCell:(YWTgCell*)cell didClickBuyWithImageView:(UIImageView *)iconView;

@end


@interface YWTgCell : UITableViewCell

/**
 *  通过一个tableView来创建一个cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *  团购模型
 */
@property (nonatomic, strong) YWTgStatus *tg;

@property(nonatomic,weak) id<YWTgCellDelegate> delegate;


@end

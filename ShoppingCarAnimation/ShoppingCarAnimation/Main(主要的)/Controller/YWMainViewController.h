//
//  YWMainViewController.h
//  YueSheng
//
//  Created by yellow on 16/7/15.
//  Copyright © 2016年 yellow. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YWMainNavBarController.h"
#import "YWMeStatus.h"
#import "YWUserStatus.h"

@interface YWMainViewController : YWMainNavBarController

//个人中心模型
@property (nonatomic,strong)YWMeStatus *meStatus;

@end

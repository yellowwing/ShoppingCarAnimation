//
//  YWTgStatus.h
//  通信录
//
//  Created by yellow on 16/7/2.
//  Copyright © 2016年 yellow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWTgStatus : NSObject

/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  价格
 */
@property (nonatomic, copy) NSString *price;
/**
 *  图片
 */
@property (nonatomic, copy) NSString *icon;
/**
 *  购买人数
 */
@property (nonatomic, copy) NSString *buyCount;

+ (instancetype)tgWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end

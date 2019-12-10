//
//  YWTgStatus.m
//  通信录
//
//  Created by yellow on 16/7/2.
//  Copyright © 2016年 yellow. All rights reserved.
//

#import "YWTgStatus.h"

@implementation YWTgStatus
+ (instancetype)tgWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end

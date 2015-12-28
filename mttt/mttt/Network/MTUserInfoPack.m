//
//  MTUserInfoPack.m
//  mttt
//
//  Created by 张勐 on 15/12/28.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTUserInfoPack.h"

@implementation MTUserInfoPack

+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id" : @"userID",@"descriptions" : @"myDescription"}];
}

@end

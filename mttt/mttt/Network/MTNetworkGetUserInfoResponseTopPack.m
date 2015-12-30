//
//  MTNetworkGetUserInfoResponseTopPack.m
//  mttt
//
//  Created by 张勐 on 15/12/30.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTNetworkGetUserInfoResponseTopPack.h"


@implementation MTNetworkGetUserInfoResponseTopPack
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"result" : @"user_result"}];
}

@end

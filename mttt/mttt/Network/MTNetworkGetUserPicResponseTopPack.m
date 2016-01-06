//
//  MTNetworkGetUserPicResponseTopPack.m
//  mttt
//
//  Created by 张勐 on 16/1/6.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTNetworkGetUserPicResponseTopPack.h"

@implementation MTNetworkGetUserPicResponseTopPack
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"result" : @"aResult"}];
}
@end

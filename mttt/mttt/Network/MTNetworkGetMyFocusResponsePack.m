//
//  MTNetworkGetMyFocusResponsePack.m
//  mttt
//
//  Created by 张勐 on 16/1/6.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTNetworkGetMyFocusResponsePack.h"

@implementation MTNetworkGetMyFocusResponsePack

+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"result" : @"aResult"}];
}

@end

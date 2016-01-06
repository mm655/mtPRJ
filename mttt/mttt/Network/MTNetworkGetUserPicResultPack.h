//
//  MTNetworkGetUserPicResultPack.h
//  mttt
//
//  Created by 张勐 on 16/1/6.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTNetworkResponseBasePack.h"

@interface MTNetworkGetUserPicResultPack : JSONModel

@property (strong, nonatomic) NSArray <Optional> * picList;

@end

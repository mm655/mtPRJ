//
//  MTNetworkGetUserPicResponseTopPack.h
//  mttt
//
//  Created by 张勐 on 16/1/6.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTNetworkResponseBasePack.h"
#import "MTNetworkGetUserPicResultPack.h"
@interface MTNetworkGetUserPicResponseTopPack : MTNetworkResponseBasePack
@property (strong, nonatomic) MTNetworkGetUserPicResultPack <Optional> * aResult;
@end

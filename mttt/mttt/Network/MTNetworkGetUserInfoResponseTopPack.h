//
//  MTNetworkGetUserInfoResponseTopPack.h
//  mttt
//
//  Created by 张勐 on 15/12/30.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTNetworkResponseBasePack.h"
#import "MTNetworkGetUserInfoResultPack.h"

@interface MTNetworkGetUserInfoResponseTopPack : MTNetworkResponseBasePack
@property (strong, nonatomic) MTNetworkGetUserInfoResultPack <Optional> * user_result;
@end

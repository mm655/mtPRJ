//
//  MTNetworkGetMyFocusResponsePack.h
//  mttt
//
//  Created by 张勐 on 16/1/6.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTNetworkResponseBasePack.h"
#import "MTNetworkGetMyFocusUserResultPack.h"
@interface MTNetworkGetMyFocusResponsePack : MTNetworkResponseBasePack

@property (strong, nonatomic) MTNetworkGetMyFocusUserResultPack <Optional> * aResult;

@end

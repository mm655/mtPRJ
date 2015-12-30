//
//  MTNetworkGetUserInfoResultPack.h
//  mttt
//
//  Created by 张勐 on 15/12/30.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MTUserInfoPack.h"
@interface MTNetworkGetUserInfoResultPack : JSONModel

@property (strong, nonatomic) MTUserInfoPack <Optional> * moto_User;

@end

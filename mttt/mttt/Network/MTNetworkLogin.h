//
//  MTNetworkLogin.h
//  mttt
//
//  Created by 张勐 on 15/12/24.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTNetworkBase.h"

@interface MTNetworkLogin : MTNetworkBase

-(void) loginWithUserName : (NSString *) userName andPassWord : (NSString *) passWord rBlock : (MTNetworkUniversalBlock) block;

@end

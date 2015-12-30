//
//  MTNetworkChangePassword.h
//  mttt
//
//  Created by 张勐 on 15/12/30.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTNetworkBase.h"

@interface MTNetworkChangePassword : MTNetworkBase

-(void) changePasswordWithUserID : (NSNumber *) userID oldPassword : (NSString *) oldPwd newPwd : (NSString *) newPwd resultBlock : (MTNetworkUniversalBlock)block;

@end

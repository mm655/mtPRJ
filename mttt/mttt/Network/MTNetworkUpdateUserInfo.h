//
//  MTNetworkUpdateUserInfo.h
//  mttt
//
//  Created by 张勐 on 15/12/30.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTNetworkBase.h"

@interface MTNetworkUpdateUserInfo : MTNetworkBase

-(void) updateUserInfoWithHeadPic : (UIImage *) headPic nickName : (NSString *) nickName city : (NSString *) city description : (NSString *) description userID : (NSNumber *) userID resultBlock : (MTNetworkUniversalBlock) block;


@end

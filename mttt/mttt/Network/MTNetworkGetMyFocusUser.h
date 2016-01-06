//
//  MTNetworkGetMyFocusUser.h
//  mttt
//
//  Created by 张勐 on 16/1/6.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTNetworkBase.h"

@interface MTNetworkGetMyFocusUser : MTNetworkBase

-(void) getMyFocusUserByID : (NSNumber *) userID rBlock : (MTNetworkUniversalBlock) block;

@end

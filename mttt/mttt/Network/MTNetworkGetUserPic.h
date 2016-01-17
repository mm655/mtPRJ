//
//  MTNetworkGetUserPic.h
//  mttt
//
//  Created by 张勐 on 16/1/6.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTNetworkBase.h"

@interface MTNetworkGetUserPic : MTNetworkBase

-(void) getUserPicByUserID : (NSNumber *) userID page:(NSNumber *) page rBlock : (MTNetworkUniversalBlock)block;

-(void) getUserPicByUserID : (NSNumber *) userID  rBlock : (MTNetworkUniversalBlock)block;


@end

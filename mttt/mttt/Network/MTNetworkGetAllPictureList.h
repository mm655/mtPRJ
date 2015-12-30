//
//  MTNetworkGetAllPictureList.h
//  mttt
//
//  Created by 张勐 on 15/12/30.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTNetworkBase.h"

@interface MTNetworkGetAllPictureList : MTNetworkBase

-(void) getAllPictureByPage : (NSNumber *)page resultBlock : (MTNetworkUniversalBlock)block;

@end

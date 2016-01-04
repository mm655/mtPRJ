//
//  MTNetworkZan.h
//  mttt
//
//  Created by 张勐 on 16/1/4.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTNetworkBase.h"

@interface MTNetworkZan : MTNetworkBase

-(void) zanByUserId : (NSNumber *) myId picId : (NSNumber *)picId rBlock : (MTNetworkUniversalBlock) block;

@end

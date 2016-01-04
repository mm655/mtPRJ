//
//  MTNetworkAddComment.h
//  mttt
//
//  Created by 张勐 on 16/1/4.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTNetworkBase.h"

@interface MTNetworkAddComment : MTNetworkBase

-(void) commentByUserID : (NSNumber *) userID picID : (NSNumber *)picID comments : (NSString *) comments rBlock : (MTNetworkUniversalBlock) block;

@end

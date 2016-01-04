//
//  MTNetworkDelFocus.h
//  mttt
//
//  Created by 张勐 on 16/1/4.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTNetworkBase.h"

@interface MTNetworkDelFocus : MTNetworkBase

-(void) delFocusUser : (NSNumber *) focusUser byUser : (NSNumber *) myId rBlock : (MTNetworkUniversalBlock) block;


@end

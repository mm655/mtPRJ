//
//  MTNetworkFindPass.h
//  mttt
//
//  Created by 张勐 on 15/12/29.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTNetworkBase.h"

@interface MTNetworkFindPass : MTNetworkBase

-(void)findpassWithEmailAddress : (NSString *) email resultBLock : (MTNetworkUniversalBlock) block;

@end

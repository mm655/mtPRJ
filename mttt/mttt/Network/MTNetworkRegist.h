//
//  MTNetworkRegist.h
//  mttt
//
//  Created by 张勐 on 15/12/24.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTNetworkBase.h"

@interface MTNetworkRegist : MTNetworkBase
-(void) registWithEmail : (NSString *)email userName : (NSString *) userName passWord : (NSString *) passWord interests : (NSString *) interests rBlock : (MTNetworkUniversalBlock) block;

@end

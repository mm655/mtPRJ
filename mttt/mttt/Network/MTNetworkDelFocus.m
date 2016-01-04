//
//  MTNetworkDelFocus.m
//  mttt
//
//  Created by 张勐 on 16/1/4.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTNetworkDelFocus.h"

@implementation MTNetworkDelFocus


-(void)delFocusUser:(NSNumber *)focusUser byUser:(NSNumber *)myId rBlock:(MTNetworkUniversalBlock)block
{
    MTNetworkHttpSession * session = [MTNetworkHttpSession new];
    [session oPostWithSubURL:MTDelFocus params:@{@"userId":myId,@"beFocuseUserId" : focusUser} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        ;
    } success:^(NSObject *responseObj) {
        ;
        MTNetworkResponseBasePack * rPack = [[MTNetworkResponseBasePack alloc] initWithDictionary:(NSDictionary *)responseObj error:nil];
        if([rPack.status boolValue] == 1)
        {
            block(MTNetworkResultTypeSuccess,nil);
        }else{
            block(MTNetworkResultTypeError,rPack.message);
        }
    } failure:^(NSString *failString) {
        block(MTNetworkResultTypeNetFail, failString);
    }];
}

@end

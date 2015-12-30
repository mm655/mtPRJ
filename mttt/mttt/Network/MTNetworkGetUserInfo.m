//
//  MTNetworkGetUserInfo.m
//  mttt
//
//  Created by 张勐 on 15/12/30.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTNetworkGetUserInfo.h"
#import "MTNetworkGetUserInfoResponseTopPack.h"

@implementation MTNetworkGetUserInfo

-(void)getUserInfoByID:(NSNumber *)userID resultBlock:(MTNetworkUniversalBlock)block
{
    MTNetworkHttpSession * session = [MTNetworkHttpSession new];
    
    [session oPostWithSubURL:MTGetUserInfo params:@{@"id" : userID} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        ;
    } success:^(NSObject *responseObj) {
        MTNetworkGetUserInfoResponseTopPack  * pack = [[MTNetworkGetUserInfoResponseTopPack alloc] initWithDictionary:(NSDictionary *)responseObj error:nil];
        if([pack.status boolValue]== YES)
        {
            block(MTNetworkResultTypeSuccess,pack.user_result);
        }else{
            block(MTNetworkResultTypeError,pack.message);
        }
    } failure:^(NSString *failString) {
        block(MTNetworkResultTypeNetFail,failString);
    }];
}

@end

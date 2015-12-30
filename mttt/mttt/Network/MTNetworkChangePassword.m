//
//  MTNetworkChangePassword.m
//  mttt
//
//  Created by 张勐 on 15/12/30.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTNetworkChangePassword.h"

@implementation MTNetworkChangePassword

-(void)changePasswordWithUserID:(NSNumber *)userID oldPassword:(NSString *)oldPwd newPwd:(NSString *)newPwd resultBlock:(MTNetworkUniversalBlock)block
{
    MTNetworkHttpSession * session = [MTNetworkHttpSession new];
    
    [session oPostWithSubURL:MTChangePassword params:@{@"id" : userID,@"oldPassword" : oldPwd,@"newPassword" : newPwd,@"surePassword" : newPwd} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        ;
    } success:^(NSObject *responseObj) {
        MTNetworkResponseBasePack * pack = [[MTNetworkResponseBasePack alloc] initWithDictionary:(NSDictionary *) responseObj error:nil];
//        NSLog(@"pack is : %@",pack);
        if([pack.status boolValue] == YES)
        {
            block(MTNetworkResultTypeSuccess, pack.message);
        }else{
            block(MTNetworkResultTypeError,pack.message);
        }
        
        ;
    } failure:^(NSString *failString) {
        block(MTNetworkResultTypeNetFail,failString);
        ;
    }];
}

@end

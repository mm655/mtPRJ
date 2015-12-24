//
//  MTNetworkLogin.m
//  mttt
//
//  Created by 张勐 on 15/12/24.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTNetworkLogin.h"
#import "MTNetworkResponseBasePack.h"
@implementation MTNetworkLogin

-(void)loginWithUserName:(NSString *)userName andPassWord:(NSString *)passWord rBlock:(MTNetworkUniversalBlock)block
{
    MTNetworkHttpSession * session = [[MTNetworkHttpSession alloc] init];
    [session oPostWithSubURL:MTNetworkLoginURL params:@{@"userName" : userName,@"passWord" : passWord} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        ;
    } success:^(NSObject *responseObj) {
        MTNetworkResponseBasePack * pack = [[MTNetworkResponseBasePack alloc] initWithDictionary:(NSDictionary *)responseObj error:nil];
        NSLog(@"success response obj : %@",pack);
    } failure:^(NSString *failString) {
        NSLog(@"error : %@",failString);
    }];
}

@end

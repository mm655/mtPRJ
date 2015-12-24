//
//  MTNetworkRegist.m
//  mttt
//
//  Created by 张勐 on 15/12/24.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTNetworkRegist.h"

@implementation MTNetworkRegist

-(void)registWithEmail:(NSString *)email userName:(NSString *)userName passWord:(NSString *)passWord interests:(NSString *)interests rBlock:(MTNetworkUniversalBlock)block
{
    MTNetworkHttpSession * session = [MTNetworkHttpSession new];
    [session oPostWithSubURL:MTNetworkRegistURL params:@{@"email" : email, @"userName" : userName, @"passWord" : passWord} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        ;
    } success:^(NSObject *responseObj) {
        MTNetworkResponseBasePack * rB = [[MTNetworkResponseBasePack alloc] initWithDictionary:(NSDictionary *)responseObj error:nil];
        NSLog(@"rS : %@",rB);
    } failure:^(NSString *failString) {
        NSLog(@"failure : %@",failString);
    }];
}

@end

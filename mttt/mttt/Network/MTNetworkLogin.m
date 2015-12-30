//
//  MTNetworkLogin.m
//  mttt
//
//  Created by 张勐 on 15/12/24.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTNetworkLogin.h"
#import "MTNetworkResponseBasePack.h"
#import "MTNetworkLoginResultPack.h"
#import "MTUserInfoStorageManager.h"


@implementation MTNetworkLogin

-(void)loginWithUserName:(NSString *)userName andPassWord:(NSString *)passWord rBlock:(MTNetworkUniversalBlock)block
{
    NSLog(@"%@   %@",userName,passWord);
    MTNetworkHttpSession * session = [[MTNetworkHttpSession alloc] init];
    [session oPostWithSubURL:MTNetworkLoginURL params:@{@"userName" : userName,@"passWord" : passWord} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        ;
    } success:^(NSObject *responseObj) {
        
        MTNetworkResponseBasePack * pack = [[MTNetworkResponseBasePack alloc] initWithDictionary:(NSDictionary *)responseObj error:nil];
        
        if([pack.status boolValue] == YES)
        {
            //restore storage here
            MTNetworkLoginResultPack * resultPack = [[MTNetworkLoginResultPack alloc] initWithDictionary:pack.result error:nil];
            
            [MagicalRecord cleanUp];
            [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:resultPack.userInfo.userName];
            
            [MTUserInfoStorageManager setNewUserInfo:resultPack.userInfo];
            block(MTNetworkResultTypeSuccess,resultPack.userInfo);
        }else{
            block(MTNetworkResultTypeError,pack.message);
        }
        
    } failure:^(NSString *failString) {
        NSLog(@"error : %@",failString);
    }];
}

@end

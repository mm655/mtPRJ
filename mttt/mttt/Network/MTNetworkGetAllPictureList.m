//
//  MTNetworkGetAllPictureList.m
//  mttt
//
//  Created by 张勐 on 15/12/30.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTNetworkGetAllPictureList.h"

@implementation MTNetworkGetAllPictureList


-(void)getAllPictureByPage:(NSNumber *)page resultBlock:(MTNetworkUniversalBlock)block
{
    MTNetworkHttpSession * session = [MTNetworkHttpSession new];
    
    [session oPostWithSubURL:MTGetAllPictureList params:@{@"begin" : page} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        ;
    } success:^(NSObject *responseObj) {
        MTNetworkResponseBasePack * pack = [[MTNetworkResponseBasePack alloc] initWithDictionary:(NSDictionary *)responseObj error:nil];
        NSLog(@"%@",pack);
        ;
    } failure:^(NSString *failString) {
        NSLog(@"failString : %@",failString);
    }];
}

@end

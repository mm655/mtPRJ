//
//  MTNetworkHttpSession.m
//  mttt
//
//  Created by 张勐 on 15/12/24.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTNetworkHttpSession.h"
#import "MTNetworkBase.h"
@implementation MTNetworkHttpSession

-(void)postWithSubURL:(NSString *)subURL params:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))cBlock success:(void (^)(NSObject *))sBlock failure:(void (^)(NSString *))fBlock
{
    AFHTTPSessionManager * session = [[AFHTTPSessionManager alloc] init];
    
    [session POST:[MTNetworkBaseURL stringByAppendingString:subURL] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        cBlock(formData);
        ;
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        sBlock(responseObject);
        ;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fBlock(error.localizedDescription);
        ;
    }];
}

-(void)oPostWithSubURL:(NSString *)subURL params:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))cBlock success:(void (^)(NSObject *))sBlock failure:(void (^)(NSString *))fBlock{

    NSError * serializationError = nil;
    AFHTTPSessionManager * session = [[AFHTTPSessionManager alloc] init];
    NSMutableURLRequest * request = [session.requestSerializer requestWithMethod:@"POST" URLString:[MTNetworkBaseURL stringByAppendingString:subURL] parameters:params error:nil];
   if(serializationError)
   {
       fBlock(serializationError.localizedDescription);
       return;
   }

    NSURLSessionDataTask * task = [session uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if(error)
        {
            fBlock(error.localizedDescription);
        }else{
            sBlock(responseObject);
        }
        ;
    }];
    
    [task resume];
}




@end

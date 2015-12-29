//
//  MTNetworkHttpSession.h
//  mttt
//
//  Created by 张勐 on 15/12/24.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^MTHttpCompleteBlock)(CGFloat completion);

@interface MTNetworkHttpSession : NSObject

/**
 *  @author Jeason, 15-12-24 15:12:10
 *
 *  @brief mutipart网络请求
 *
 */
-(void) postWithSubURL : (NSString *) subURL params : (NSDictionary *) params constructingBodyWithBlock : (void (^)(id <AFMultipartFormData> formData))cBlock success : (void (^)(NSObject * responseObj))sBlock failure : (void (^)(NSString * failString))fBlock completeBlock : (MTHttpCompleteBlock) ccBlock;


-(void) oPostWithSubURL : (NSString *) subURL params : (NSDictionary *) params constructingBodyWithBlock : (void (^)(id <AFMultipartFormData> formData))cBlock success : (void (^)(NSObject * responseObj))sBlock failure : (void (^)(NSString * failString))fBlock ;



@end



//(nullable void (^)(id <AFMultipartFormData> formData))
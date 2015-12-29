//
//  MTNetworkBase.h
//  mttt
//
//  Created by 张勐 on 15/12/24.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const MTNetworkBaseURL;
extern NSString * const MTNetworkLoginURL;
extern NSString * const MTNetworkRegistURL;
extern NSString * const MTUpPicture;
typedef NS_ENUM(NSInteger, MTNetworkResultType)
{
    MTNetworkResultTypeSuccess,
    MTNetworkResultTypeError,
    MTNetworkResultTypeNetFail
};

typedef void (^MTNetworkUniversalBlock)(MTNetworkResultType resultType, NSObject * addInfo);


@interface MTNetworkBase : NSObject

@end

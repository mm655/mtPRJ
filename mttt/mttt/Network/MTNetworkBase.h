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
extern NSString * const MTFindPass;
extern NSString * const MTUpdateUserInfo;
extern NSString * const MTGetUserInfo;
extern NSString * const MTChangePassword;
extern NSString * const MTGetMainList;
extern NSString * const MTGetAllPictureList;
extern NSString * const MTAddComments;
extern NSString * const MTAddFocus;
extern NSString * const MTDelFocus;
extern NSString * const MTNetworkZanURL;
extern NSString * const MTNetworkDelZanURL;
extern NSString * const MTNetworkJubaoURL;
extern NSString * const MTNetworkGetMyFocus;
extern NSString * const MTNetworkGetUserPicURL;


typedef NS_ENUM(NSInteger, MTNetworkResultType)
{
    MTNetworkResultTypeSuccess,
    MTNetworkResultTypeError,
    MTNetworkResultTypeNetFail
};

typedef void (^MTNetworkUniversalBlock)(MTNetworkResultType resultType, NSObject * addInfo);


@interface MTNetworkBase : NSObject

@end

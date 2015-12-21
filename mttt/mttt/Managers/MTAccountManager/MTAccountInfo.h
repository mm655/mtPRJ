//
//  MTAccountInfo.h
//  mttt
//
//  Created by 张勐 on 15/12/21.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MTAccountInfo : JSONModel

@property (strong, nonatomic) NSNumber <Optional> * loginState;
@property (strong, nonatomic) NSNumber <Optional> * userID;
@property (strong, nonatomic) NSString <Optional> * userName;

@end

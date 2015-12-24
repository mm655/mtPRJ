//
//  MTNetworkResponseBasePack.h
//  mttt
//
//  Created by 张勐 on 15/12/24.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MTNetworkResponseBasePack : JSONModel

@property (strong, nonatomic) NSString <Optional> * message;
@property (strong, nonatomic) NSNumber <Optional> * status;

@end

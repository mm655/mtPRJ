//
//  MTPull2RefreshState.h
//  mttt
//
//  Created by 张勐 on 15/12/28.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, MTPull2RefreshState) {
    MTPull2RefreshStateNormal = 0,
    MTPull2RefreshStateChanging,
    MTPull2RefreshStateRotating
};


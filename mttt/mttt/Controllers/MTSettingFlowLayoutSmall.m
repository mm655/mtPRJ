//
//  MTSettingFlowLayoutSmall.m
//  mttt
//
//  Created by 张勐 on 16/1/6.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import "MTSettingFlowLayoutSmall.h"

@implementation MTSettingFlowLayoutSmall

-(instancetype)init
{
    self = [super init];
    self.itemSize = CGSizeMake(SCWidth / 3 - 2, SCWidth / 3 - 2);
    self.headerReferenceSize = CGSizeMake(SCWidth, 200);
    self.minimumInteritemSpacing = 1;
    self.minimumLineSpacing = 1;
    return self;
}

@end

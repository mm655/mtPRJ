//
//  MTNearbyCollectionViewLayout.m
//  motu
//
//  Created by 张勐 on 15/11/21.
//  Copyright © 2015年 ___ZM___. All rights reserved.
//

#import "MTNearbyCollectionViewLayout.h"

static float nearByMargin = 2;

@implementation MTNearbyCollectionViewLayout

-(instancetype)init
{
    self = [super init];
    CGFloat width = ceilf((SCWidth - 2*nearByMargin)/3);
    self.itemSize = CGSizeMake(width, width);
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = nearByMargin;
    self.headerReferenceSize = CGSizeMake(SCWidth, 0);
    self.footerReferenceSize = CGSizeMake(SCWidth, 0);
    return self;
}

@end

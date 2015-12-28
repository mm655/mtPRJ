//
//  MTNearbyCollectionView.h
//  motu
//
//  Created by 张勐 on 15/11/21.
//  Copyright © 2015年 ___ZM___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTPull2RefreshState.h"

@interface MTNearbyCollectionView : UICollectionView

@property (assign, nonatomic) MTPull2RefreshState state;

@end

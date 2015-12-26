//
//  MTfilterCollectionViewCell.h
//  mttt
//
//  Created by 张勐 on 15/12/26.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTfilterCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) NSNumber * imageNum;

@property (strong, nonatomic) UIImageView * mainImageView;
@property (strong, nonatomic) UILabel * filterNameLabel;
@end

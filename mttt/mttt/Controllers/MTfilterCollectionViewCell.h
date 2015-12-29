//
//  MTfilterCollectionViewCell.h
//  mttt
//
//  Created by 张勐 on 15/12/26.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTfilterCollectionViewCell : UICollectionViewCell
{
    NSArray * _filterNameArray;
    UIImage * _fdImage0;
    UIImage * _fdImage1;
    UIImage * _fdImage2;
    UIImage * _fdImage3;
    UIImage * _fdImage4;
    UIImage * _fdImage5;
    UIImage * _fdImage6;
    UIImage * _fdImage7;
    UIImage * _fdImage8;
    UIImage * _fdImage9;
    UIImage * _fdImage10;
    UIImage * _fdImage11;
    UIImage * _fdImage12;
    UIImage * _fdImage13;
}
@property (strong, nonatomic) NSNumber * imageNum;

@property (strong, nonatomic) UIImage * orgImage;

@property (strong, nonatomic) UIImageView * mainImageView;
@property (strong, nonatomic) UILabel * filterNameLabel;

//@property (strong, nonatomic)
@end

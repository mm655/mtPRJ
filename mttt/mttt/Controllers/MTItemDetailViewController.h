//
//  MTItemDetailViewController.h
//  mttt
//
//  Created by 张勐 on 16/1/5.
//  Copyright © 2016年 ZhangMeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTPicInfoPack.h"


@interface MTItemDetailViewController : UIViewController

@property (strong, nonatomic) MTPicInfoPack * infoPack;
@property (strong, nonatomic) UIScrollView * mainScrollView;
@property (strong, nonatomic) UITextView * ptView;

@property (strong, nonatomic)    UIImageView * headImageView;
@property (strong, nonatomic)    UILabel * nameLabel;
@property (strong, nonatomic)    UIButton * focusButton;
@property (strong, nonatomic)    UIImageView * mainImageView;
@property (strong, nonatomic)    UITextField * zanField;
@property (strong, nonatomic)    UITextField * pingField;
@property (strong, nonatomic)    UIButton * jubaoButton;

@property (strong, nonatomic)    UILabel * distanceLabel;
@property (strong, nonatomic)    UILabel * timeLabel;




@end

//
//  MTMainTableViewCell.h
//  mttt
//
//  Created by 张勐 on 15/12/25.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTMainTableViewCell : UITableViewCell
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






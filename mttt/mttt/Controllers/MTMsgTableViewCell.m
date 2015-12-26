//
//  MTMsgTableViewCell.m
//  mttt
//
//  Created by 张勐 on 15/12/25.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTMsgTableViewCell.h"

@implementation MTMsgTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = 22;
    _headImageView.top  = 10;
    _headImageView.left = 10;
    _headImageView.image = [UIImage imageNamed:@"login_pic1"];
    [self addSubview:_headImageView];
    
    _focusButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    _focusButton.layer.masksToBounds = YES;
    _focusButton.layer.cornerRadius = 5;
    _focusButton.backgroundColor = MTGreen;
    _focusButton.y = _headImageView.y;
    _focusButton.right = SCWidth - 5;
    [self addSubview:_focusButton];
    [_focusButton setImage:[UIImage imageNamed:@"back_array_left"] forState:UIControlStateNormal];
    [_focusButton setTitle:@"关注" forState:UIControlStateNormal];
    [_focusButton setTitleColor:MTWhite forState:UIControlStateNormal];
    [self addSubview:_focusButton];
    
    _nameLabel = [[UILabel alloc] init];
    [self addSubview:_nameLabel];
    PREPCONSTRAINTS(_nameLabel);
    [self addConstraint:CONSTRAINT_SETTING_HEIGHT(_nameLabel, 44)];
    [self addConstraint:CONSTRAINT_LEFT2RIGHT(_nameLabel, _headImageView, 4)];
    [self addConstraint:CONSTRAINT_RIGHT2LEFT(_nameLabel, _focusButton, -4)];
    ALIGN_CENTER_V(_nameLabel);
    _nameLabel.backgroundColor = MTGray;
    
    _itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 54, 54)];
//    _itemImageView.left = _focusButton.left;
    _itemImageView.right = SCWidth - 10;
    _itemImageView.y = _focusButton.y;
    _itemImageView.image = [UIImage imageNamed:@"login_pic2"];
    [self addSubview:_itemImageView];
    
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

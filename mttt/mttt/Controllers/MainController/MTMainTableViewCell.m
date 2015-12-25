//
//  MTMainTableViewCell.m
//  mttt
//
//  Created by 张勐 on 15/12/25.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTMainTableViewCell.h"

@implementation MTMainTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)init
{
    self = [super init];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 44, 44)];
    _headImageView.layer.cornerRadius = 22;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.image = [UIImage imageNamed:@"login_pic1"];
    [self addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCWidth / 3, 44)];
    _nameLabel.left = _headImageView.right + 5;
    _nameLabel.y = _headImageView.y;
    _nameLabel.font = [UIFont systemFontOfSize:12.0f];
    _nameLabel.textColor = MTBlue;
    _nameLabel.text = @"kimi";
    [self addSubview:_nameLabel];
    
    _focusButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, 44)];
    _focusButton.right = SCWidth - 5;
    _focusButton.y = _nameLabel.y;
    _focusButton.layer.cornerRadius = 6;
    _focusButton.backgroundColor = MTGreen;
    [_focusButton setImage:[UIImage imageNamed:@"back_array_left"] forState:UIControlStateNormal];
    [_focusButton setTitle:@"关注" forState:UIControlStateNormal];
    [_focusButton setTitleColor:MTWhite forState:UIControlStateNormal];
    [_focusButton addTarget:self action:@selector(focusButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_focusButton];
    
    _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, SCWidth)];
    _mainImageView.top = 64;
    _mainImageView.image = [UIImage imageNamed:@"login_pic2"];
    [self addSubview:_mainImageView];
    
    _zanField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    _zanField.top = _mainImageView.bottom + 5;
    _zanField.left = 5;
    _zanField.userInteractionEnabled = NO;
    _zanField.textColor = MTGray;
    UIImageView * ZLImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    ZLImageView.image = [UIImage imageNamed:@"zan_red"];
    _zanField.leftView = ZLImageView;
    _zanField.leftViewMode = UITextFieldViewModeAlways;
    _zanField.text = @" 100";
    [self addSubview:_zanField];
    
    _pingField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    _pingField.top = _zanField.top;
    _pingField.left = _zanField.right;
    _pingField.textColor = MTGray;
    UIImageView * PLImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    PLImageView.backgroundColor = MTGreen;
    PLImageView.image = [UIImage imageNamed:@"comment"];
    _pingField.userInteractionEnabled = NO;
    _pingField.leftView = PLImageView;
    _pingField.leftViewMode = UITextFieldViewModeAlways;
    _pingField.text = @" 100";
    [self addSubview:_pingField];
    
    _jubaoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [_jubaoButton setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    _jubaoButton.right = SCWidth - 5;
    _jubaoButton.y = _pingField.y;
    [self addSubview:_jubaoButton];
    
    
    
    
    
    return self;
}


-(void) focusButtonClick
{
    NSLog(@"focus button click");
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

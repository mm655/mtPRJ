//
//  MTMainTableViewCell.m
//  mttt
//
//  Created by 张勐 on 15/12/25.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTMainTableViewCell.h"
#import "MTCommentPack.h"
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
    UIButton * userDButton = [[UIButton alloc] initWithFrame:_headImageView.frame];
    [self addSubview:userDButton];
    [userDButton addTarget:self action:@selector(userDetailRequest:) forControlEvents:UIControlEventTouchUpInside];
    
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
    _focusButton.backgroundColor = [UIColor clearColor];
    [_focusButton setImage:[UIImage imageNamed:@"back_array_left"] forState:UIControlStateNormal];
    [_focusButton setTitle:@"关注" forState:UIControlStateNormal];
    [_focusButton setTitleColor:MTWhite forState:UIControlStateNormal];
    [_focusButton addTarget:self action:@selector(focusButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_focusButton];
    
    _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, SCWidth)];
    _mainImageView.top = 64;
    _mainImageView.image = [UIImage imageNamed:@"login_pic2"];
    [self addSubview:_mainImageView];
    
    UIButton * mainButton = [[UIButton alloc] initWithFrame:_mainImageView.frame];
    [self addSubview:mainButton];
    [mainButton addTarget:self action:@selector(mainButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    UIButton * zanButton = [[UIButton alloc] initWithFrame:_zanField.frame];
    [self addSubview:zanButton];
    [zanButton addTarget:self action:@selector(zanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    [_jubaoButton addTarget:self action:@selector(jubaoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _pingView1 = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _pingView1.backgroundColor = MTGreen;
    _pingView1.top = _jubaoButton.bottom + 5;
    [self addSubview:_pingView1];
    
    _pingView2 = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self addSubview:_pingView2];
    
    _pingView3 = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self addSubview:_pingView3];
    _pingView1.userInteractionEnabled = NO;
    _pingView2.userInteractionEnabled = NO;
    _pingView3.userInteractionEnabled = NO;
    _pingView1.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _pingView2.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _pingView3.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return self;
}


-(void) focusButtonClick
{
//    NSLog(@"focus button click");
    if(self.cellId)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:MTMainCellFocusNotification object:nil userInfo:@{@"cellId" : self.cellId}];
    }
}


-(void) mainButtonClick : (UIButton *) button
{
    if(self.cellId)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:MTMainCellDetailNotification object:nil userInfo:@{@"cellId" : self.cellId}];
    }
}

-(void) zanButtonClick : (UIButton *)button
{
    if(self.cellId)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:MTMainCellZanNotification object:nil userInfo:@{@"cellId" : self.cellId}];
    }
}

-(void) jubaoButtonClick : (UIButton *) button
{
    if(self.cellId)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:MTMainCellJubaoNotification object:nil userInfo:@{@"cellId" : self.cellId}];
    }
}

-(void) userDetailRequest : (UIButton *) button
{
    if(self.cellId)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:MTMainCellUserNotification object:nil userInfo:@{@"cellId" : self.cellId}];
    }
}

-(void)drawRect:(CGRect)rect
{
    NSLog(@"run draw rect here");
    [super drawRect:rect];
    int count = 0;
    _pingView1.height = 0;
    _pingView2.height = 0;
    _pingView3.height = 0;
    if(self.commentArray.count != 0)
    {
        for(NSDictionary * tmpDic in self.commentArray)
        {
            count += 1;
            MTCommentPack * pack = [[MTCommentPack alloc] initWithDictionary:tmpDic error:nil];
            NSString * finalString = @"";
            CGRect rect = CGRectMake(0, 0, 0, 0);
            if(pack.user.nickName.length != 0)
            {
                finalString = [pack.user.nickName stringByAppendingString:[NSString stringWithFormat:@":%@",pack.comments]];
                rect = [finalString boundingRectWithSize:CGSizeMake(SCWidth - 20, SCHeight) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]} context:NULL];
            }else{
                finalString = [@"无名氏" stringByAppendingString:[NSString stringWithFormat:@":%@",pack.comments]];
                rect = [finalString boundingRectWithSize:CGSizeMake(SCWidth - 20, SCHeight) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f]} context:NULL];
            }
            
            switch (count) {
                case 1:
                    _pingView1.width = SCWidth - 20;
                    _pingView1.x = SCWidth / 2;
                    _pingView1.height = rect.size.height;
                    _pingView1.font = [UIFont systemFontOfSize:12.0f];
                    _pingView1.text = finalString;
                    _pingView1.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                    break;
                case 2:
                    _pingView2.width = SCWidth - 20;
                    _pingView2.x = SCWidth / 2;
                    _pingView2.height = rect.size.height;
                    _pingView2.font = [UIFont systemFontOfSize:12.0f];
                    _pingView2.text = finalString;
                    _pingView2.top = _pingView1.bottom + 5;
                    break;
                case 3:
                    _pingView3.width = SCWidth - 20;
                    _pingView3.x = SCWidth / 2;
                    _pingView3.height = rect.size.height;
                    _pingView3.font = [UIFont systemFontOfSize:12.0f];
                    _pingView3.text = finalString;
                    _pingView3.top = _pingView2.bottom + 5;
                    break;
                default:
                    break;
            }
        }
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end

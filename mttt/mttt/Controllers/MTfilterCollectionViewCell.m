//
//  MTfilterCollectionViewCell.m
//  mttt
//
//  Created by 张勐 on 15/12/26.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTfilterCollectionViewCell.h"

@implementation MTfilterCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    UIImageView * mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - 40, frame.size.width -40)];
    mainImageView.tag = 1000;
    mainImageView.backgroundColor = MTWhite;
    mainImageView.x = frame.size.width / 2;
    mainImageView.y = frame.size.width / 2;
    [self addSubview:mainImageView];
    
    UILabel * filterNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 20)];
    filterNameLabel.bottom = frame.size.height;
    filterNameLabel.x = frame.size.width / 2;
    [self addSubview:filterNameLabel];
    filterNameLabel.textAlignment = NSTextAlignmentCenter;
    filterNameLabel.font = [UIFont systemFontOfSize:12.0f];
    filterNameLabel.textColor = MTWhite;
    filterNameLabel.text = @"abcd123";
    filterNameLabel.tag = 1001;
    
    return self;
}

//-(void)setMainImageView:(UIImageView *)mainImageView
//{
//    
//}
-(void)setImageNum:(NSNumber *)imageNum
{
    static int a = 0;
//    NSNumber * tmpNum = @(a++);
    UILabel * tmpLabel = [self viewWithTag:1001];
    tmpLabel.text = [NSString stringWithFormat:@"%zi",a++];
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.backgroundColor = MTGray;
}

@end

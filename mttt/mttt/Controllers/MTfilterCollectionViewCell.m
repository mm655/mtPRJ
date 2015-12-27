//
//  MTfilterCollectionViewCell.m
//  mttt
//
//  Created by 张勐 on 15/12/26.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTfilterCollectionViewCell.h"
#import "CLFilterBase.h"
//@protocol CLFilterBaseProtocol
@implementation MTfilterCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    UIImageView * mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - 40, frame.size.width -40)];
    mainImageView.tag = 1000;
    mainImageView.backgroundColor = MTWhite;
    mainImageView.x = frame.size.width / 2;
    mainImageView.y = frame.size.width / 2;
    _mainImageView = mainImageView;
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
    _filterNameArray = @[
                             @"CLDefaultEmptyFilter",
                             @"CLDefaultLinearFilter",
                             @"CLDefaultVignetteFilter",
                             @"CLDefaultInstantFilter",
                             @"CLDefaultProcessFilter",
                             @"CLDefaultTransferFilter",
                             @"CLDefaultSepiaFilter",
                             @"CLDefaultChromeFilter",
                             @"CLDefaultFadeFilter",
                             @"CLDefaultCurveFilter",
                             @"CLDefaultTonalFilter",
                             @"CLDefaultNoirFilter",
                             @"CLDefaultMonoFilter",
                             @"CLDefaultInvertFilter"
                         ];
    
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
    
    int curNum = [imageNum intValue] % 14;
//    int curNum = 0;
//    CLDefaultEmptyFilter * defaultFilter = [CLDefaultEmptyFilter new];
    UIImage * orgImage = [UIImage imageNamed:@"login_pic2"];
    
    UIImage * resultImage;
    switch (curNum) {
        case 0:
            resultImage = [CLDefaultEmptyFilter applyFilter:orgImage];
            break;
        case 1:
            resultImage = [CLDefaultLinearFilter applyFilter:orgImage];
            break;
        case 2:
            resultImage = [CLDefaultVignetteFilter applyFilter:orgImage];
            break;
        case 3:
            resultImage = [CLDefaultInstantFilter applyFilter:orgImage];
            break;
        case 4:
            resultImage = [CLDefaultProcessFilter applyFilter:orgImage];
            break;
        case 5:
            resultImage = [CLDefaultTransferFilter applyFilter:orgImage];
            break;
        case 6:
            resultImage = [CLDefaultSepiaFilter applyFilter:orgImage];
            break;
        case 7:
            resultImage = [CLDefaultChromeFilter applyFilter:orgImage];
            break;
        case 8:
            resultImage = [CLDefaultFadeFilter applyFilter:orgImage];
            break;
        case 9:
            resultImage = [CLDefaultCurveFilter applyFilter:orgImage];
            break;
        case 10:
            resultImage = [CLDefaultTonalFilter applyFilter:orgImage];
            break;
        case 11:
            resultImage = [CLDefaultNoirFilter applyFilter:orgImage];
            break;
        case 12:
            resultImage = [CLDefaultMonoFilter applyFilter:orgImage];
            break;
        case 13:
            resultImage = [CLDefaultInvertFilter applyFilter:orgImage];
            break;
        default:
            resultImage = [CLDefaultEmptyFilter applyFilter:orgImage];
            break;
    }
    
    _mainImageView.image = resultImage;
    
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.backgroundColor = MTGray;
}

@end

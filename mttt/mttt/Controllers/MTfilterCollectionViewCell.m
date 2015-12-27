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
            if(_fdImage0)
            {
                resultImage = _fdImage0;
                break;
            }
            resultImage = [CLDefaultEmptyFilter applyFilter:orgImage];
            _fdImage0 = resultImage;
            break;
        case 1:
            if(_fdImage1)
            {
                resultImage = _fdImage1;
                break;
            }
            resultImage = [CLDefaultLinearFilter applyFilter:orgImage];
            _fdImage1 = resultImage;
            break;
        case 2:
            if(_fdImage2)
            {
                resultImage = _fdImage2;
                break;
            }
            resultImage = [CLDefaultVignetteFilter applyFilter:orgImage];
            _fdImage2 = resultImage;
            break;
        case 3:
            if(_fdImage3)
            {
                resultImage = _fdImage3;
                break;
            }
            resultImage = [CLDefaultInstantFilter applyFilter:orgImage];
            _fdImage3 = resultImage;
            break;
        case 4:
            if(_fdImage4)
            {
                resultImage = _fdImage4;
                break;
            }
            resultImage = [CLDefaultProcessFilter applyFilter:orgImage];
            _fdImage4 = resultImage;
            break;
        case 5:
            if(_fdImage5)
            {
                resultImage = _fdImage5;
                break;
            }
            resultImage = [CLDefaultTransferFilter applyFilter:orgImage];
            _fdImage5 = resultImage;
            break;
        case 6:
            if(_fdImage6)
            {
                resultImage = _fdImage6;
                break;
            }
            resultImage = [CLDefaultSepiaFilter applyFilter:orgImage];
            _fdImage6 = resultImage;
            break;
        case 7:
            if(_fdImage7)
            {
                resultImage = _fdImage7;
                break;
            }
            resultImage = [CLDefaultChromeFilter applyFilter:orgImage];
            _fdImage7 = resultImage;
            break;
        case 8:
            if(_fdImage8)
            {
                resultImage = _fdImage8;
                break;
            }
            resultImage = [CLDefaultFadeFilter applyFilter:orgImage];
            _fdImage8 = resultImage;
            break;
        case 9:
            if(_fdImage9)
            {
                resultImage = _fdImage9;
                break;
            }
            resultImage = [CLDefaultCurveFilter applyFilter:orgImage];
            _fdImage9 = resultImage;
            break;
        case 10:
            if(_fdImage10)
            {
                resultImage = _fdImage10;
                break;
            }
            resultImage = [CLDefaultTonalFilter applyFilter:orgImage];
            _fdImage10 = resultImage;
            break;
        case 11:
            if(_fdImage11)
            {
                resultImage = _fdImage11;
                break;
            }
            resultImage = [CLDefaultNoirFilter applyFilter:orgImage];
            _fdImage11 = resultImage;
            break;
        case 12:
            if(_fdImage12)
            {
                resultImage = _fdImage12;
                break;
            }
            resultImage = [CLDefaultMonoFilter applyFilter:orgImage];
            _fdImage12 = resultImage;
            break;
        case 13:
            if(_fdImage13)
            {
                resultImage = _fdImage13;
                break;
            }
            resultImage = [CLDefaultInvertFilter applyFilter:orgImage];
            _fdImage13 = resultImage;
            break;
        default:
            resultImage = [CLDefaultEmptyFilter applyFilter:orgImage];
//            _fdImage0 = resultImage;
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

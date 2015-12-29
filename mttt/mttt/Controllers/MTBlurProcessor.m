//
//  MTBlurProcessor.m
//  mttt
//
//  Created by 张勐 on 15/12/29.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTBlurProcessor.h"
#import "CLBlurTool.h"

@implementation MTBlurProcessor

-(void)circleBlurWithOpaque:(CGFloat)opaque orgImage:(UIImage *)orgImage resultBlock:(MTBlurResultBlock)block
{
    CLBlurTool * tT = [CLBlurTool new];
    tT.originalImage = orgImage;
    tT.blurSlider = [UISlider new];
    tT.blurSlider.value = opaque;
    tT.blurType = kCLBlurTypeCircle;
    
    CLBlurBand * bView = [[CLBlurBand alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    bView.color = MTBlack;
    bView.scale = 1.0f;
    bView.offset = 0;
    tT.bandImageRect = CGRectMake(-100, -200, 400, 400);
    tT.bandView = bView;
    
    CLBlurCircle * cView = [[CLBlurCircle alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    tT.circleView = cView;
    
    [tT executeWithCompletionBlock:^(UIImage *image, NSError *error, NSDictionary *userInfo) {
        block(image);
        ;
    }];
}

-(void)lineBlurWithOpaque:(CGFloat)opaque orgImage:(UIImage *)orgImage resultBlock:(MTBlurResultBlock)block
{
    CLBlurTool * tT = [CLBlurTool new];
    tT.originalImage = orgImage;
    tT.blurSlider = [UISlider new];
    tT.blurSlider.value = opaque;
    tT.blurType = kCLBlurTypeBand;
    
    CLBlurBand * bView = [[CLBlurBand alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    bView.color = MTBlack;
    bView.scale = 1.0f;
    bView.offset = 0;
    tT.bandImageRect = CGRectMake(-100, -200, 400, 400);
    tT.bandView = bView;
    
    CLBlurCircle * cView = [[CLBlurCircle alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    tT.circleView = cView;
    
    [tT executeWithCompletionBlock:^(UIImage *image, NSError *error, NSDictionary *userInfo) {
        block(image);
        ;
    }];
}

@end

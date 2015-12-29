//
//  MTBlurProcessor.h
//  mttt
//
//  Created by 张勐 on 15/12/29.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^MTBlurResultBlock)(UIImage * image);

@interface MTBlurProcessor : NSObject

-(void) circleBlurWithOpaque : (CGFloat) opaque orgImage : (UIImage *) orgImage resultBlock : (MTBlurResultBlock) block;


-(void) lineBlurWithOpaque : (CGFloat) opaque orgImage : (UIImage *) orgImage resultBlock : (MTBlurResultBlock) block;


@end

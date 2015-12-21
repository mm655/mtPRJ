//
//  LoginTrangleView.m
//  mttt
//
//  Created by 张勐 on 15/12/21.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "LoginTrangleView.h"

@implementation LoginTrangleView

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 0, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width / 2, 0.0f);
    
    
//    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
//    CGContextAddLineToPoint(context, 0, rect.size.width / 2);
    
    CGContextClosePath(context);
    
    [[UIColor whiteColor] setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

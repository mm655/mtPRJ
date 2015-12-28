//
//  MTTableViewHeader.m
//  motu
//
//  Created by 张勐 on 15/11/22.
//  Copyright © 2015年 ___ZM___. All rights reserved.
//

#import "MTTableViewHeader.h"

@implementation MTTableViewHeader

-(instancetype)init
{
    self = [super init];
    if(!self.alreadyInit)
    {
        [self prepareMyHeader];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self.alreadyInit)
    {
        [self prepareMyHeader];
    }
    return self;
}

-(void) prepareMyHeader
{
    self.alreadyInit = YES;
    UIActivityIndicatorView * indicateView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self addSubview:indicateView];
    [indicateView startAnimating];
    indicateView.alpha = 1.0f;
    indicateView.hidesWhenStopped = NO;
    indicateView.tag = 101115; // tag instruction
    PREPCONSTRAINTS(indicateView);
    ALIGN_CENTER(indicateView);
    self.backgroundColor = [UIColor lightGrayColor];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

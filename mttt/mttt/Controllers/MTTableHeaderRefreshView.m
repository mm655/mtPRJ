//
//  MTTableHeaderRefreshView.m
//  mttt
//
//  Created by 张勐 on 15/12/28.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTTableHeaderRefreshView.h"

@implementation MTTableHeaderRefreshView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startRefreshing) name:MTStartRefreshing object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mtendRefreshing) name:MTEndRefreshing object:nil];
    
    
    _indicateView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self addSubview:_indicateView];
    PREPCONSTRAINTS(_indicateView);
    ALIGN_CENTER_H(_indicateView);
    ALIGN_CENTER_V(_indicateView);
//    [_indicateView startAnimating];
    _indicateView.hidesWhenStopped = NO;
    
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
}

-(void) startRefreshing
{
    [_indicateView startAnimating];
}


-(void) mtendRefreshing
{
    [_indicateView stopAnimating];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

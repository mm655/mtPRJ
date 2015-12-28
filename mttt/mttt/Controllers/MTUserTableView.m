//
//  MTUserTableView.m
//  motu
//
//  Created by 张勐 on 15/11/21.
//  Copyright © 2015年 ___ZM___. All rights reserved.
//

#import "MTUserTableView.h"

@implementation MTUserTableView

-(instancetype)init
{
    self = [super init];
    [self prepareAddtion];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
//    [self prepareAddtion];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    [self prepareAddtion];
    return self;
}

-(void) prepareAddtion
{
    [self addObserver:self forKeyPath:@"mtState" options:NSKeyValueObservingOptionNew context:NULL];
    [self addObserver:self forKeyPath:@"myAlpha" options:NSKeyValueObservingOptionNew context:NULL];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
//    NSLog(@"change observed, keyPath : %@",keyPath);
//    NSLog(@"the value we get is : %@",change[NSKeyValueChangeNewKey]);
    NSNumber * num = change[NSKeyValueChangeNewKey];
    if([num intValue] == 0)
    {
        if([self viewWithTag:101115])
        {
            UIActivityIndicatorView * tmpIView = (UIActivityIndicatorView *)[self viewWithTag:101115];
            [tmpIView stopAnimating];
        }
    }else if([num intValue] == 1)
    {
        if([self viewWithTag:101115])
        {
            UIActivityIndicatorView * tmpIView = (UIActivityIndicatorView *)[self viewWithTag:101115];
            [tmpIView startAnimating];
        }

    }
    
}

-(void)dealloc	
{
    [self removeObserver:self forKeyPath:@"mtState" context:NULL];
    [self removeObserver:self forKeyPath:@"myAlpha" context:NULL];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

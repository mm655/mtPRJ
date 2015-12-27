//
//  MTFilterCollectionView.m
//  mttt
//
//  Created by 张勐 on 15/12/26.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTFilterCollectionView.h"
#import "MTfilterCollectionViewCell.h"
@implementation MTFilterCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    self.delegate = self;
    self.dataSource = self;
    
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    [collectionView registerClass:[MTfilterCollectionViewCell class] forCellWithReuseIdentifier:@"MTFilterCell"];
    return 10;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MTfilterCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MTFilterCell" forIndexPath:indexPath   ];
    cell.imageNum = @(indexPath.row);
//    [cell setNeedsDisplay];
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

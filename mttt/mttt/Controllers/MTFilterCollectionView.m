//
//  MTFilterCollectionView.m
//  mttt
//
//  Created by 张勐 on 15/12/26.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTFilterCollectionView.h"
#import "MTfilterCollectionViewCell.h"
#import "CLFilterBase.h"


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
    MTfilterCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MTFilterCell" forIndexPath:indexPath];
    cell.orgImage = self.orgImage;
    cell.imageNum = @(indexPath.row);
//    [cell setNeedsDisplay];
    return cell;
}

#pragma mark collectionView delegate here

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage * resultImage;
    switch (indexPath.row) {
        case 0:
            resultImage = [CLDefaultEmptyFilter applyFilter:self.orgImage];
            break;
        case 1:
            resultImage = [CLDefaultLinearFilter applyFilter:_orgImage];
            break;
        case 2:
            resultImage = [CLDefaultVignetteFilter applyFilter:_orgImage];
            break;
        case 3:
            resultImage = [CLDefaultInstantFilter applyFilter:_orgImage];
            break;
        case 4:
            resultImage = [CLDefaultProcessFilter applyFilter:_orgImage];
            break;
        case 5:
            resultImage = [CLDefaultTransferFilter applyFilter:_orgImage];
            break;
        case 6:
            resultImage = [CLDefaultSepiaFilter applyFilter:_orgImage];
            break;
        case 7:
            resultImage = [CLDefaultChromeFilter applyFilter:_orgImage];
            break;
        case 8:
            resultImage = [CLDefaultFadeFilter applyFilter:_orgImage];
            break;
        case 9:
            resultImage = [CLDefaultCurveFilter applyFilter:_orgImage];
            break;
        case 10:
            resultImage = [CLDefaultTonalFilter applyFilter:_orgImage];
            break;
        case 11:
            resultImage = [CLDefaultNoirFilter applyFilter:_orgImage];
            break;
        case 12:
            resultImage = [CLDefaultMonoFilter applyFilter:_orgImage];
            break;
        case 13:
            resultImage = [CLDefaultInvertFilter applyFilter:_orgImage];
            break;
        default:
            resultImage = [CLDefaultEmptyFilter applyFilter:_orgImage];
            break;
    }
    if([self.mtDelegate respondsToSelector:@selector(didUpDateSelectImage:)])
    {
        [self.mtDelegate didUpDateSelectImage:resultImage];
    }
}

#pragma mark end

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

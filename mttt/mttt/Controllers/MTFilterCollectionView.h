//
//  MTFilterCollectionView.h
//  mttt
//
//  Created by 张勐 on 15/12/26.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MTFilterProtocol <NSObject>

-(void) didUpDateSelectImage : (UIImage *) image;

@end

@interface MTFilterCollectionView : UICollectionView <UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UIImage * orgImage;
@property (assign, nonatomic) id <MTFilterProtocol> mtDelegate;

@end

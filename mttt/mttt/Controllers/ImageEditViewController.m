//
//  ImageEditViewController.m
//  mttt
//
//  Created by 张勐 on 15/12/26.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "ImageEditViewController.h"
#import "MTFilterCollectionView.h"
#import "MTFilterFlowLayout.h"
#import "MTBlurProcessor.h"

typedef NS_ENUM(NSInteger, MTBlurState)
{
    MTBlurStateCircle,
    MTBlurStateLine
};

@interface ImageEditViewController () <MTFilterProtocol>

@property (strong, nonatomic) NSTimer * blurTimer;
@property (strong, nonatomic) MTBlurProcessor * blurProccessor;
@property (assign, nonatomic) MTBlurState blurState;
@property (assign, nonatomic) CGFloat circleSlideRec;
@property (assign, nonatomic) CGFloat lineSlideRec;

@property (strong, nonatomic) MTFilterCollectionView * filterCollectionView;
@property (strong, nonatomic) UIView * blurView;

@property (strong, nonatomic) UIImage * step1Image;
@end

@implementation ImageEditViewController

-(instancetype)initWithOrgImage:(UIImage *)image
{
    self = [super init];
    self.orgImage = image;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MTBlack;
    UIButton * disButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [disButton setImage:[UIImage imageNamed:@"back_array_left"] forState:UIControlStateNormal];
    [self.view addSubview:disButton];
    [disButton addTarget:self action:@selector(disButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, SCWidth, SCWidth)];
    _mainImageView.image = _orgImage;
//    _mainImageView.translatesAutoresizingMaskIntoConstraints = YES;
    _step1Image = _orgImage;
    _mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_mainImageView];
    
    UIButton * nextStepButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 44)];
    [nextStepButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"下一步" attributes:@{NSForegroundColorAttributeName : MTBlue, NSFontAttributeName : [UIFont systemFontOfSize:14.0f]}] forState:UIControlStateNormal];
    nextStepButton.right = SCWidth;
    [self.view addSubview:nextStepButton];
    [nextStepButton addTarget:self action:@selector(nextStepClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * actionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, 64)];
    actionView.top = _mainImageView.bottom;
    actionView.backgroundColor = MTGray;
    [self.view addSubview:actionView];
    
    UIButton * filterButton = [[UIButton alloc] init];
    _filterButton = filterButton;
    [actionView addSubview:filterButton];
    PREPCONSTRAINTS(filterButton);
    ALIGN_LEFT(filterButton, 0);
    ALIGN_TOP(filterButton, 0);
    ALIGN_BOTTOM(filterButton, 0);
    ALIGN_RIGHT(filterButton, SCWidth / 2);
    _filterButton.contentMode = UIViewContentModeScaleAspectFit;
    [filterButton setImage:[[UIImage imageNamed:@"filter_icon_blue"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeTile] forState:UIControlStateNormal];
    filterButton.tag = 1000;
    [filterButton addTarget:self action:@selector(actionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * blurButton = [[UIButton alloc] init];
    _blurButton = blurButton;
    [actionView addSubview:blurButton];
    PREPCONSTRAINTS(blurButton);
    ALIGN_TOP(blurButton, 0);
    ALIGN_BOTTOM(blurButton, 0);
    ALIGN_RIGHT(blurButton, 0);
    ALIGN_LEFT(blurButton, SCWidth / 2);
//    blurButton.backgroundColor = MTBlue;
    [blurButton setImage:[[UIImage imageNamed:@"move_icon_white"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    blurButton.tag = 1001;
    [blurButton addTarget:self action:@selector(actionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat remainingSpace = SCHeight - actionView.bottom;

    MTFilterCollectionView * MTFCView = [[MTFilterCollectionView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, remainingSpace) collectionViewLayout:[[MTFilterFlowLayout alloc] initWithItemHeight:remainingSpace - 5]];
    self.filterCollectionView = MTFCView;
    MTFCView.mtDelegate = self;
    MTFCView.orgImage = self.orgImage;
    MTFCView.bottom = SCHeight;
    MTFCView.backgroundColor = MTBlack;
    [self.view addSubview:MTFCView];
    
    UIView * blurActionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, remainingSpace)];
    blurActionView.bottom = SCHeight;
    [self.view addSubview:blurActionView];
    blurActionView.backgroundColor = [UIColor blackColor];
    self.blurView = blurActionView;
    self.blurView.left = SCWidth;
    
    UIButton * circleBlurButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    [circleBlurButton setBackgroundImage:[UIImage imageNamed:@"circle_blur_s"] forState:UIControlStateNormal];
    circleBlurButton.x = SCWidth / 4;
    circleBlurButton.y = remainingSpace / 2;
    circleBlurButton.tag = 1587;
    [circleBlurButton addTarget:self action:@selector(blurButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [blurActionView addSubview:circleBlurButton];
    
    UIButton * lineBlurButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    [lineBlurButton setBackgroundImage:[UIImage imageNamed:@"line_blur_ds"] forState:UIControlStateNormal];
    lineBlurButton.y = remainingSpace / 2;
    lineBlurButton.x = SCWidth * 3 / 4;
    lineBlurButton.tag = 1589;
    [lineBlurButton addTarget:self action:@selector(blurButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [blurActionView addSubview:lineBlurButton];
    
    UISlider * slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, SCWidth / 1.32, 13)];
    slider.bottom = _mainImageView.bottom - 20;
    slider.x = SCWidth / 2;
    slider.tag = 887;
    slider.hidden = YES;
    [self.view addSubview:slider];
    slider.value = 0.0f;
    [slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    self.blurState = MTBlurStateCircle;
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _blurTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(blurTimerProc) userInfo:nil repeats:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_blurTimer invalidate];
    _blurTimer = nil;
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"main fram : %@",NSStringFromCGRect(_mainImageView.frame));
        ;
    });
//    [self.view addSubview:_mainImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) disButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) actionButtonClick : (UIButton *) button
{
    if(button.tag == 1000)
    {
        UISlider * slider = [self.view viewWithTag:887];
        if(slider)
        {
            slider.hidden = YES;
        }
        [_filterButton setImage:[UIImage imageNamed:@"filter_icon_blue"] forState:UIControlStateNormal];
        [_blurButton setImage:[UIImage imageNamed:@"move_icon_white"] forState:UIControlStateNormal];
        [UIView transitionWithView:self.view duration:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.blurView.left = SCWidth;
            self.filterCollectionView.left = 0;
            ;
        } completion:^(BOOL finished) {
            ;
        }];
    }else{
        
        UISlider * slider = [self.view viewWithTag:887];
        if(slider)
        {
            slider.hidden = NO;
        }

        
        [_filterButton setImage:[UIImage imageNamed:@"filter_icon_white"] forState:UIControlStateNormal];
        [_blurButton setImage:[UIImage imageNamed:@"move_icon_blue"] forState:UIControlStateNormal];
        
        [UIView transitionWithView:self.view duration:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.blurView.left = 0;
            self.filterCollectionView.right = 0;
            ;
        } completion:^(BOOL finished) {
            ;
        }];
        
        
        
    }
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void) nextStepClick
{
    
}

#pragma mark mtFilterProtocol
-(void)didUpDateSelectImage:(UIImage *)image
{
    if(image)
    {
        _mainImageView.image = image;
        self.step1Image = image;
    }
}
#pragma mark end


-(void) sliderChanged : (UISlider *) slider
{
    NSLog(@"new slider is : %f",slider.value);
}

-(void) blurTimerProc
{
    UISlider * slider = [self.view viewWithTag:887];
    if(!slider)
    {
        return;
    }
    
    if(!_blurProccessor)
    {
        _blurProccessor = [[MTBlurProcessor alloc] init];
    }
    
    if(self.blurState == MTBlurStateCircle)
    {
        if(self.circleSlideRec != slider.value)
        {
            self.circleSlideRec = slider.value;
            [_blurProccessor circleBlurWithOpaque:slider.value orgImage:self.step1Image resultBlock:^(UIImage *image) {
                _mainImageView.image = image;
            }];
        }
    }else if(self.blurState == MTBlurStateLine)
    {
        if(self.lineSlideRec != slider.value)
        {
            self.lineSlideRec = slider.value;
            [_blurProccessor lineBlurWithOpaque:slider.value orgImage:self.step1Image resultBlock:^(UIImage *image) {
                _mainImageView.image = image;
            }];
        }
    }
}

-(void) blurButtonClick : (UIButton *) button
{
    if(button.tag == 1587)
    {
        UIButton * lineButton = [self.view viewWithTag:1589];
        [button setBackgroundImage:[UIImage imageNamed:@"circle_blur_s"] forState:UIControlStateNormal];
        [lineButton setBackgroundImage:[UIImage imageNamed:@"line_blur_ds"] forState:UIControlStateNormal];
        self.blurState = MTBlurStateCircle;
        UISlider * slider = [self.view viewWithTag:887];
        if(slider)
        {
            slider.value = self.circleSlideRec;
        }
    }else{
        UIButton * circleButton = [self.view viewWithTag:1587];
        [circleButton setBackgroundImage:[UIImage imageNamed:@"circle_blur_ds"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"line_blur_s"] forState:UIControlStateNormal];
        self.blurState = MTBlurStateLine;
        UISlider * slider = [self.view viewWithTag:887];
        if(slider)
        {
            slider.value = self.lineSlideRec;
        }
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

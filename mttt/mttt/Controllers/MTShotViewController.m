//
//  MTShotViewController.m
//  mttt
//
//  Created by 张勐 on 15/12/24.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTShotViewController.h"
#import "MTNetworkLogin.h"
#import "MTNetworkRegist.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "ImageEditViewController.h"


@interface MTShotViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation MTShotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    _preViewView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, SCWidth, SCWidth)];
    [self.view addSubview:_preViewView];
    _captureSession = [[AVCaptureSession alloc] init];
    if([_captureSession canSetSessionPreset:AVCaptureSessionPreset1280x720])
    {
        [_captureSession setSessionPreset:AVCaptureSessionPreset1280x720];
    }
    
    NSArray * myDeivices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for(AVCaptureDevice * myDevice in myDeivices)
    {
        if([myDevice position] == AVCaptureDevicePositionBack)
        {
            _deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:myDevice error:nil];
        }
    }
    
    _stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    [_stillImageOutput setOutputSettings:@{AVVideoCodecKey : AVVideoCodecJPEG}];
    
    if([_captureSession canAddInput:_deviceInput])
    {
        [_captureSession addInput:_deviceInput];
    }
    
    if([_captureSession canAddOutput:_stillImageOutput])
    {
        [_captureSession addOutput:_stillImageOutput];
    }
    
    _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    _previewLayer.frame = CGRectMake(0, 0, SCWidth, SCWidth);
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [_preViewView.layer addSublayer:_previewLayer];
    
    UIButton * rButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//    rButton.backgroundColor = MTGray;
    [rButton setImage:[UIImage imageNamed:@"close_cross"] forState:UIControlStateNormal];
    [rButton addTarget:self action:@selector(rButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rButton];
    
    UIView * actionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCWidth, 44)];
    actionView.top = _preViewView.bottom;
    actionView.backgroundColor = MTGray;
    [self.view addSubview:actionView];
    
    UIButton * linesButton = [[UIButton alloc] init];
    [actionView addSubview:linesButton];
    PREPCONSTRAINTS(linesButton);
    ALIGN_LEFT(linesButton, 0);
    ALIGN_TOP(linesButton, 0);
    ALIGN_BOTTOM(linesButton, 0);
    linesButton.backgroundColor = MTGreen;
    
    UIButton * camsSButton = [[UIButton alloc] init];
    [actionView addSubview:camsSButton];
    PREPCONSTRAINTS(camsSButton);
    [actionView addConstraint:CONSTRAINT_LEFT2RIGHT(camsSButton, linesButton, 0)];
    ALIGN_TOP(camsSButton, 0);
    ALIGN_BOTTOM(camsSButton, 0);
    MATCH_WIDTH(camsSButton, linesButton);
    camsSButton.backgroundColor = MTBlue;
    
    UIButton * flashButton = [[UIButton alloc] init];
    [actionView addSubview:flashButton];
    PREPCONSTRAINTS(flashButton);
    [actionView addConstraint:CONSTRAINT_LEFT2RIGHT(flashButton, camsSButton, 0)];
    ALIGN_TOP(flashButton, 0);
    ALIGN_BOTTOM(flashButton, 0);
    ALIGN_RIGHT(flashButton, 0);
    MATCH_WIDTH(flashButton, camsSButton);
    flashButton.backgroundColor = MTWhite;
    
    UIButton * shotButton = [[UIButton alloc] init];
    CGFloat spaceLeft = SCHeight - SCWidth - 88;
    shotButton.width = spaceLeft / 2;
    shotButton.height = spaceLeft / 2;
    shotButton.x = SCWidth / 2;
    shotButton.y = SCHeight - spaceLeft / 2;
    [shotButton setImage:[UIImage imageNamed:@"shot_button_ds"] forState:UIControlStateNormal];
    [shotButton setImage:[UIImage imageNamed:@"shot_button_s"] forState:UIControlStateSelected];
    [self.view addSubview:shotButton];
    [shotButton addTarget:self action:@selector(shotButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    _alaButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, shotButton.width - 20, shotButton.width - 20)];
//    _alaButton.width = 2;
    _alaButton.x = shotButton.left / 2;
    _alaButton.y = shotButton.y;
    _alaButton.contentMode = UIViewContentModeScaleAspectFill;
    [_alaButton addTarget:self action:@selector(pickImageFromAlbum) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_alaButton];
    
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_captureSession startRunning];
    PHFetchResult * allResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:nil];
    [allResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ;
        [[PHImageManager defaultManager] requestImageForAsset:(PHAsset *)obj targetSize:CGSizeMake(100, 100) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            [_alaButton setImage:result forState:UIControlStateNormal];
            ;
        }];
        *stop = YES;
    }];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_captureSession stopRunning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) pickImageFromAlbum
{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    [picker.navigationBar setBackgroundImage:[UIImage imageNamed:@"bigShadow"] forBarMetrics:UIBarMetricsCompact];
    UIView * tV = [[UIView alloc] initWithFrame:CGRectMake(0, -20, SCWidth, 64)];
    picker.navigationBar.tintColor = MTWhite;
    picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : MTWhite, NSFontAttributeName : [UIFont systemFontOfSize:18.0f]};
    tV.backgroundColor = MTBlue;
//    tV.tintColor = MTWhite;
    
    
    [picker.navigationBar insertSubview:tV atIndex:0];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}



-(void) rButtonClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}


#pragma mark image picker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"dic we get is : %@",info);
    UIImage * orgImage = info[UIImagePickerControllerOriginalImage];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_alaButton setImage:orgImage forState:UIControlStateNormal];
    });
    
    ImageEditViewController * editController = [[ImageEditViewController alloc] initWithOrgImage:orgImage];
    
    ;
//    [picker dismissViewControllerAnimated:YES completion:nil];
    [picker dismissViewControllerAnimated:NO completion:^{
        [self presentViewController:editController animated:YES completion:nil];
    }];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void) shotButtonClick
{
    _connection = [_stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    [_stillImageOutput captureStillImageAsynchronouslyFromConnection:_connection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage * image = [[UIImage alloc] initWithData:imageData];
        [_alaButton setImage:image forState:UIControlStateNormal];
        ;
    }];
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

//
//  MTShotViewController.m
//  mttt
//
//  Created by 张勐 on 15/12/24.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import "MTShotViewController.h"

@interface MTShotViewController ()

@end

@implementation MTShotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    _preViewView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCWidth, SCWidth)];
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
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_captureSession startRunning];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

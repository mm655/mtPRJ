//
//  MTShotViewController.h
//  mttt
//
//  Created by 张勐 on 15/12/24.
//  Copyright © 2015年 ZhangMeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MTShotViewController : UIViewController
{
    UIView * _preViewView;
    AVCaptureSession * _captureSession;
    AVCaptureStillImageOutput * _stillImageOutput;
    AVCaptureDeviceInput * _deviceInput;
    AVCaptureVideoPreviewLayer * _previewLayer;
    AVCaptureConnection * _connection;
    
    UIButton * _alaButton;
}

@end

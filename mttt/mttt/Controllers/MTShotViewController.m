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
{
    AVCaptureDevicePosition _curPositon;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    _preViewView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, SCWidth, SCWidth)];
    [self.view addSubview:_preViewView];
    _captureSession = [[AVCaptureSession alloc] init];
    if([_captureSession canSetSessionPreset:AVCaptureSessionPreset640x480])
    {
        [_captureSession setSessionPreset:AVCaptureSessionPreset640x480];
    }
    
    NSArray * myDeivices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
//    [myDeivices]
    for(AVCaptureDevice * myDevice in myDeivices)
    {
        
        if([myDevice position] == AVCaptureDevicePositionBack)
        {
            [myDevice lockForConfiguration:nil];
//            myDevice.flashMode = AVCaptureFlashModeOn;
            _captureDevice = myDevice;
            [myDevice unlockForConfiguration];
            _deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:myDevice error:nil];
//            _deviceInput.
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
    [linesButton setImage:[UIImage imageNamed:@"shot_grid_ds"] forState:UIControlStateNormal];
    [linesButton addTarget:self action:@selector(linesButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * camsSButton = [[UIButton alloc] init];
    [actionView addSubview:camsSButton];
    PREPCONSTRAINTS(camsSButton);
    [actionView addConstraint:CONSTRAINT_LEFT2RIGHT(camsSButton, linesButton, 0)];
    ALIGN_TOP(camsSButton, 0);
    ALIGN_BOTTOM(camsSButton, 0);
    MATCH_WIDTH(camsSButton, linesButton);
    camsSButton.backgroundColor = MTBlue;
    [camsSButton setImage:[UIImage imageNamed:@"shot_rear_ds"] forState:UIControlStateNormal];
    [camsSButton addTarget:self action:@selector(camsSButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * flashButton = [[UIButton alloc] init];
    [actionView addSubview:flashButton];
    PREPCONSTRAINTS(flashButton);
    [actionView addConstraint:CONSTRAINT_LEFT2RIGHT(flashButton, camsSButton, 0)];
    ALIGN_TOP(flashButton, 0);
    ALIGN_BOTTOM(flashButton, 0);
    ALIGN_RIGHT(flashButton, 0);
    MATCH_WIDTH(flashButton, camsSButton);
    flashButton.backgroundColor = MTGreen;
    [flashButton setImage:[UIImage imageNamed:@"shot_flash_ds"] forState:UIControlStateNormal];
    [flashButton addTarget:self action:@selector(flashButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
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
    picker.allowsEditing = YES;
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
//    NSLog(@"dic we get is : %@",info);
    
    UIImage * orgImage = info[UIImagePickerControllerOriginalImage];
    
    orgImage = info[UIImagePickerControllerEditedImage];
    
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
        
        NSLog(@"imageSize is : %@",NSStringFromCGSize(image.size));
        
//        CGImageRef cgimage = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, 0, 360, 360));
        
//        NSData * data = UIImageJPEGRepresentation(image, 1.0f);
//        
//        data = UIImagePNGRepresentation(image);
        
//        image.imageOrientation
//        NSLog(@"orientation : %zi",image.imageOrientation);
//        NSLog(@"%@",data);
//        UIImage * newImage = [[UIImage alloc] initWithData:data];
        
        CGImageRef imageRef = [[self fixOrientation:image] CGImage];
        CGRect rect = CGRectMake(0, (image.size.height - image.size.width)/2, image.size.width,image.size.width);
        CGImageRef rImage = CGImageCreateWithImageInRect(imageRef, rect);
        UIImage * resultImage = [[UIImage alloc] initWithCGImage:rImage];
        
        ImageEditViewController * editController = [[ImageEditViewController alloc] initWithOrgImage:[self fixOrientation:resultImage]];
        NSLog(@"image size is : %@",NSStringFromCGSize(image.size));
        NSLog(@"result image size : %@",NSStringFromCGSize(resultImage.size));
        
//        ImageEditViewController * editController = [[ImageEditViewController alloc] initWithOrgImage:resultImage];
        
        
        [self presentViewController:editController animated:NO completion:nil];
        ;
    }];
}


- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

-(void) linesButtonClick : (UIButton *) button
{
    if(!button.selected)
    {
        button.selected = YES;
        [button setImage:[UIImage imageNamed:@"shot_grid_s"] forState:UIControlStateNormal];
        
        UIView * heng1 = [[UIView alloc] initWithFrame:CGRectMake(0, SCWidth / 3, SCWidth, 1)];
        heng1.backgroundColor = MTWhite;
        [_preViewView addSubview:heng1];
        heng1.tag = 666;
        
        UIView * heng2 = [[UIView alloc] initWithFrame:CGRectMake(0, SCWidth / 1.5f, SCWidth, 1)];
        heng2.backgroundColor = MTWhite;
        [_preViewView addSubview:heng2];
        heng2.tag = 666;
 
        UIView * shu1 = [[UIView alloc] initWithFrame:CGRectMake(SCWidth / 3, 0, 1, SCWidth)];
        shu1.backgroundColor = MTWhite;
        [_preViewView addSubview:shu1];
        shu1.tag = 666;
        
        UIView * shu2 = [[UIView alloc] initWithFrame:CGRectMake(SCWidth / 1.5f, 0, 1, SCWidth)];
        shu2.backgroundColor = MTWhite;
        [_preViewView addSubview : shu2];
        shu2.tag = 666;
        
    }else{
        button.selected = NO;
        [button setImage:[UIImage imageNamed:@"shot_grid_ds"] forState:UIControlStateNormal];
        for(UIView * tmpView in [_preViewView subviews])
        {
            if(tmpView.tag == 666)
            {
                [tmpView removeFromSuperview];
            }
        }
    }
}

-(void) camsSButtonClick : (UIButton *) button
{
    if(button.selected)
    {
        button.selected = NO;
        [button setImage:[UIImage imageNamed:@"shot_rear_ds"] forState:UIControlStateNormal];
        
        [_captureSession stopRunning];
        NSArray * myDeivices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
        [_captureSession removeInput:_deviceInput];
        for(AVCaptureDevice * myDevice in myDeivices)
        {
            if([myDevice position] == AVCaptureDevicePositionBack)
            {
                [myDevice lockForConfiguration:nil];
                myDevice.flashMode = AVCaptureFlashModeOn;
                _captureDevice = myDevice;
                [myDevice unlockForConfiguration];
                _deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:myDevice error:nil];
            }
        }
        if([_captureSession canAddInput:_deviceInput])
        {
            [_captureSession addInput:_deviceInput];
        }
        [_captureSession startRunning];
    }else{
        button.selected = YES;
        [button setImage:[UIImage imageNamed:@"shot_rear_s"] forState:UIControlStateNormal];
        
        [_captureSession stopRunning];
        NSArray * myDeivices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
        [_captureSession removeInput:_deviceInput];
        for(AVCaptureDevice * myDevice in myDeivices)
        {
            if([myDevice position] == AVCaptureDevicePositionFront)
            {
//                [myDevice lockForConfiguration:nil];
//                myDevice.flashMode = AVCaptureFlashModeOn;
//                _captureDevice = myDevice;
//                [myDevice unlockForConfiguration];
                _deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:myDevice error:nil];
            }
        }
        if([_captureSession canAddInput:_deviceInput])
        {
            [_captureSession addInput:_deviceInput];
        }
        [_captureSession startRunning];
    }
}

-(void) flashButtonClick : (UIButton *) button
{
    if(button.selected)
    {
        button.selected = NO;
        [button setImage:[UIImage imageNamed:@"shot_flash_ds"] forState:UIControlStateNormal];
        if(_captureDevice.flashAvailable)
        {
            [_captureDevice lockForConfiguration:nil];
            _captureDevice.flashMode = AVCaptureFlashModeOff;
        }
    }else{
        button.selected = YES;
        [button setImage:[UIImage imageNamed:@"shot_flash_s"] forState:UIControlStateNormal];
        if(_captureDevice.flashAvailable)
        {
            [_captureDevice lockForConfiguration:nil];
            _captureDevice.flashMode = AVCaptureFlashModeOn;
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

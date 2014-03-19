//
//  QRCodeViewController.h
//  ScanQRCode
//
//  Created by Xchobo on 2014/3/19.
//  Copyright (c) 2014年 Xchobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#define SCANTIME 0.02

@interface QRCodeViewController : UIViewController
<AVCaptureMetadataOutputObjectsDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    NSString *stringValue;  // 回傳用
}

@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, retain) UIImageView * line;

- (NSString *)returnData;

@end

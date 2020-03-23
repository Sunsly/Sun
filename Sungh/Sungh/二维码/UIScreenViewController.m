//
//  UIScreenViewController.m
//  Sungh
//
//  Created by yonyouqiche on 2020/3/23.
//  Copyright © 2020 yonyouqiche. All rights reserved.
//

#import "UIScreenViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface UIScreenViewController ()<AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoDataOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

@implementation UIScreenViewController

#pragma mark ------>viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
//        FYXAlertView *alert =  [[FYXAlertView alloc]initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height)];
//        alert.delegate = self;
//        [alert  setTitleMsgAlertView:@"提示" titleFont:18 alertMsg:@"请在手机【设置】-【隐私】-【相机】选项中，允许【丰云行】访问您的相机" msgFont:15 msgColor:RGBAAllColor(0x323232, 1)];
//        [alert.cancelBtn setTitle:@"设置" forState:UIControlStateNormal];
//        [alert.cancelBtn setTitleColor:[UIColor colorWithRed:11/255.0 green:171/255.0 blue:254/255.0 alpha:1.0] forState:UIControlStateNormal];
//        [[[UIApplication sharedApplication] keyWindow] addSubview:alert];
        
    }else{
        [self setupScanner];
    }
    // Do any additional setup after loading the view from its nib.
}

#pragma mark ------> 扫码初始化
- (void)setupScanner{
    // 1、获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2、创建摄像设备输入流
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 3、创建元数据输出流
    AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 设置扫描范围（每一个取值0～1，以屏幕右上角为坐标原点）
    // 注：微信二维码的扫描范围是整个屏幕，这里并没有做处理（可不用设置）;
    // 如需限制扫描框范围，打开下一句注释代码并进行相应调整
    //    metadataOutput.rectOfInterest = CGRectMake(0.05, 0.2, 0.7, 0.6);
    
    // 4、创建会话对象
    _session = [[AVCaptureSession alloc] init];
    // 并设置会话采集率
    _session.sessionPreset = AVCaptureSessionPreset1920x1080;
    
    // 5、添加元数据输出流到会话对象
    [_session addOutput:metadataOutput];
    
    // 创建摄像数据输出流并将其添加到会话对象上,  --> 用于识别光线强弱
    self.videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    [_videoDataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    [_session addOutput:_videoDataOutput];
    
    // 6、添加摄像设备输入流到会话对象
    [_session addInput:deviceInput];
    
    // 7、设置数据输出类型(如下设置为条形码和二维码兼容)，需要将数据输出添加到会话后，才能指定元数据类型，否则会报错
    metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code,  AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    // 8、实例化预览图层, 用于显示会话对象
    _videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    // 保持纵横比；填充层边界
    _videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
//    _videoPreviewLayer.frame = CGRectMake((SCREEN_W - 253)/2, SCREEN_H/2 - 258/2+1, 253, 257);

    [self.view.layer insertSublayer:_videoPreviewLayer atIndex:0];
    // 9、启动会话
}
#pragma mark ------>扫码代理
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects != nil && metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        NSLog(@"%@",[obj stringValue]);//拿到了设备id
        NSString *str = [obj stringValue];
        if (str.length == 0) {
        
        }else{
            [_session stopRunning];
        }
    } else {
    }
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    // 这个方法会时时调用，但内存很稳定
    CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL,sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary *metadata = [[NSMutableDictionary alloc] initWithDictionary:(__bridge NSDictionary*)metadataDict];
    CFRelease(metadataDict);
    NSDictionary *exifMetadata = [[metadata objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
//    float brightnessValue = [[exifMetadata objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] floatValue];
}
//灯
- (IBAction)onlightAction:(id)sender {
    if (0) {
        /** 打开手电筒 */
        AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        NSError *error = nil;
        if ([captureDevice hasTorch]) {
            BOOL locked = [captureDevice lockForConfiguration:&error];
            if (locked) {
                captureDevice.torchMode = AVCaptureTorchModeOn;
                [captureDevice unlockForConfiguration];
            }
        }
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)),                  dispatch_get_main_queue(), ^{
            AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            if ([device hasTorch]) {
                [device lockForConfiguration:nil];
                [device setTorchMode: AVCaptureTorchModeOff];
                [device unlockForConfiguration];
            }
            
        });
//        self.openLabel.text = @"轻触开灯";
    }
}
- (void)show{
    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
     if([[UIApplication sharedApplication] canOpenURL:url]) {
         [[UIApplication sharedApplication] openURL:url];
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

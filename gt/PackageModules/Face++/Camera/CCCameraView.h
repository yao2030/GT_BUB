//
//  CCCameraView.h
//  CCCamera
//
//  Created by 佰道聚合 on 2017/7/5.
//  Copyright © 2017年 cyd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCVideoPreview.h"
#import "VicCameraBottomView.h"
#import "VicNavTopView.h"

@class CCCameraView;
@protocol CCCameraViewDelegate <NSObject>
@optional;

/// 闪光灯
-(void)flashLightAction:(CCCameraView *)cameraView handle:(void(^)(NSError *error))handle;
/// 补光
-(void)torchLightAction:(CCCameraView *)cameraView handle:(void(^)(NSError *error))handle;
/// 转换摄像头
-(void)swicthCameraAction:(CCCameraView *)cameraView animation:(BOOL)animation handle:(void(^)(NSError *error))handle;
/// 自动聚焦曝光
-(void)autoFocusAndExposureAction:(CCCameraView *)cameraView handle:(void(^)(NSError *error))handle;
/// 聚焦
-(void)focusAction:(CCCameraView *)cameraView point:(CGPoint)point handle:(void(^)(NSError *error))handle;
/// 曝光
-(void)exposAction:(CCCameraView *)cameraView point:(CGPoint)point handle:(void(^)(NSError *error))handle;
/// 缩放
-(void)zoomAction:(CCCameraView *)cameraView factor:(CGFloat)factor;

/// 取消
-(void)cancelAction:(CCCameraView *)cameraView;
/// 拍照
-(void)takePhotoAction:(CCCameraView *)cameraView;
/// 停止录制视频
-(void)stopRecordVideoAction:(CCCameraView *)cameraView;
/// 开始录制视频
-(void)startRecordVideoAction:(CCCameraView *)cameraView;
/// 改变拍摄类型 1：拍照 2：视频
-(void)didChangeTypeAction:(CCCameraView *)cameraView type:(NSInteger)type;

@end

@interface CCCameraView : UIView

@property(nonatomic, strong) VicNavTopView *topView;      // 上面的bar

@property(nonatomic, weak) id <CCCameraViewDelegate> delegate;

@property(nonatomic, strong, readonly) CCVideoPreview *previewView;

@property(nonatomic, assign, readonly) NSInteger type; // 1：拍照 2：视频

@property(nonatomic, strong) VicCameraBottomView *bottomView;   // 下面的bar

//-(void)changeTorch:(BOOL)on;

//-(void)changeFlash:(BOOL)on;

@end

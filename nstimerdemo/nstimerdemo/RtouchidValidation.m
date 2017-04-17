//
//  RtouchidValidation.m
//  nstimerdemo
//
//  Created by Rain on 2017/4/13.
//  Copyright © 2017年 Rain. All rights reserved.
//

#import "RtouchidValidation.h"


#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface RtouchidValidation ()

@property (nonatomic,assign)BOOL RtouchIdResuit;

@end

@implementation RtouchidValidation



+(BOOL)touchIdValidationresult
{
    RtouchidValidation *Validation = [[RtouchidValidation alloc]init];
    [Validation touchIdValidation];
    return Validation.RtouchIdResuit;
}
-(void)touchIdValidation{
    
    NSError *error = nil;
    //创建LAContext
    LAContext *context = [LAContext new]; //这个属性是设置指纹输入失败之后的弹出框的选项
    context.localizedFallbackTitle = @"没有忘记密码";
    
    WS(weakSelf);
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                             error:&error]) {
        NSLog(@"支持指纹识别");
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:@"指纹解锁" reply:^(BOOL success, NSError * _Nullable error) {
                    if (success) {
                       weakSelf.RtouchIdResuit =YES;
                        NSLog(@"验证成功 刷新主界面");
                    }else{
                        NSLog(@"%@",error.localizedDescription);
                        switch (error.code) {
                            case LAErrorSystemCancel:
                            {
                                NSLog(@"系统取消授权，如其他APP切入");
                                break;
                            }
                            case LAErrorUserCancel:
                            {
                                NSLog(@"用户取消验证Touch ID");
                                break;
                            }
                            case LAErrorAuthenticationFailed:
                            {
                                NSLog(@"授权失败");
                                break;
                            }
                            case LAErrorPasscodeNotSet:
                            {
                                NSLog(@"系统未设置密码");
                                break;
                            }
                            case LAErrorTouchIDNotAvailable:
                            {
                                NSLog(@"设备Touch ID不可用，例如未打开");
                                break;
                            }
                            case LAErrorTouchIDNotEnrolled:
                            {
                                NSLog(@"设备Touch ID不可用，用户未录入");
                                break;
                            }
                            case LAErrorUserFallback:
                            {
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                    NSLog(@"用户选择输入密码，切换主线程处理");
                                }];
                                break;
                            }
                            default:
                            {
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                    NSLog(@"其他情况，切换主线程处理");
                                }];
                                break;
                            }
                        }
                    }
                }];
    }else{
        NSLog(@"不支持指纹识别");

        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                break;
            }
        }
        
        NSLog(@"%@",error.localizedDescription);
    }
}


@end

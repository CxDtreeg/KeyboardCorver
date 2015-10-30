//
//  UIViewController+KeyboardCorver.m
//  KeyBoardTest
//
//  Created by CxDtreeg on 15/10/30.
//  Copyright © 2015年 CxDtreeg. All rights reserved.
//

#import "UIViewController+KeyboardCorver.h"

@implementation UIViewController (KeyboardCorver)

@dynamic keyboardHideTapGesture;
@dynamic objectView;

static void * keyboardHideTapGestureKey = (void *)@"keyboardHideTapGesture";
static void * objectViewKey = (void *)@"objectViewKey";

#pragma mark - 设置键盘隐藏单击手势 setter getter
- (void)setKeyboardHideTapGesture:(UITapGestureRecognizer *)keyboardHideTapGesture{
    objc_setAssociatedObject(self, keyboardHideTapGestureKey, keyboardHideTapGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)getKeyboardHideTapGesture{
    return objc_getAssociatedObject(self, keyboardHideTapGestureKey);
}

#pragma mark - 设置获取目标对象 setter getter
- (void)setObjectView:(UIView *)objectView{
    objc_setAssociatedObject(self, objectViewKey, objectView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)getObjectView{
    return objc_getAssociatedObject(self, objectViewKey);
}

#pragma mark - 添加键盘通知
- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotify:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotify:) name:UIKeyboardWillHideNotification object:nil];
    
    [self setKeyboardHideTapGesture:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandel)]];
    [self.view addGestureRecognizer:[self getKeyboardHideTapGesture]];
}

#pragma mark - 清理通知和移除手势
- (void)clearNotificationAndGesture{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.view removeGestureRecognizer:[self getKeyboardHideTapGesture]];
}

#pragma mark - 单击手势调用
- (void)tapGestureHandel{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

#pragma mark - 查找第一响应者
- (void)findFirstResponse:(UIView *)view{
    UIView * ojView = [self getObjectView];
    ojView = nil;
    for (UIView * tempView in view.subviews) {
        if ([tempView isFirstResponder] && [tempView isKindOfClass:[UITextField class]]) {//要进行类型判断
            [self setObjectView:tempView];
        }
        if (tempView.subviews.count != 0) {
            [self findFirstResponse:tempView];
        }
    }
}

#pragma mark - 键盘通知接收处理
- (void)keyboardNotify:(NSNotification *)notify{
    
    NSValue * frameNum = [notify.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rect = frameNum.CGRectValue;
    CGFloat keyboardHeight = rect.size.height;//键盘高度
    
    CGFloat duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];//获取键盘动画持续时间
    NSInteger curve = [[notify.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];//获取动画曲线
    
    if ([notify.name isEqualToString:UIKeyboardWillShowNotification]) {//键盘显示
        [self findFirstResponse:self.view];
        UIView * tempView = [self getObjectView];
        CGPoint point = [tempView convertPoint:tempView.frame.origin toView:self.view];//计算响应者到和屏幕的绝对位置
        point = CGPointMake(point.x/2.0, point.y/2.0);//将像素单位转为点单位
        CGFloat keyboardY = APPWINDOWHEIGHT - keyboardHeight;
        if (point.y > keyboardY) {
            CGFloat offsetY = keyboardY-point.y-tempView.frame.size.height;
            if (duration > 0) {
                [UIView animateWithDuration:duration delay:0 options:curve<<16 animations:^{
                    self.view.transform = CGAffineTransformMakeTranslation(0, offsetY);
                } completion:^(BOOL finished) {
                    
                }];
            }else{
                self.view.transform = CGAffineTransformMakeTranslation(0, offsetY);
            }
            
        }
        
    }else if ([notify.name isEqualToString:UIKeyboardWillHideNotification]){//键盘隐藏
        if (duration > 0) {
            [UIView animateWithDuration:duration delay:0 options:curve<<16 animations:^{
                self.view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }else{
            self.view.transform = CGAffineTransformIdentity;
        }
    }
}


@end

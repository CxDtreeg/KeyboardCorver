//
//  UIViewController+KeyboardCorver.h
//  KeyBoardTest
//
//  Created by CxDtreeg on 15/10/30.
//  Copyright © 2015年 CxDtreeg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#define APPWINDOWHEIGHT ([UIScreen mainScreen].bounds.size.height)
#define APPWINDOWWIDTH  ([UIScreen mainScreen].bounds.size.width)

@interface UIViewController (KeyboardCorver)

#pragma mark - 添加键盘通知
- (void)addNotification;

#pragma mark - 清理通知和移除手势 在控制器的dealloc中记得要释放
- (void)clearNotificationAndGesture;

@end

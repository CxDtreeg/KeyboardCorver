# KeyboardCorver
一个解决iOS 输入框当键盘弹出时被遮挡的ViewController类目

#怎样使用
使用方式很简单，只需要将工程中的`UIViewController+KeyboardCorver.h`和`UIViewController+KeyboardCorver.m`拖到你的项目里面，然后`import "UIViewController+KeyboardCorver.h"`。
使用的时候调用`[self addNotification]`方法添加通知。不使用的时候要记得清理通知调用`[self clearNotificationAndGesture]`。

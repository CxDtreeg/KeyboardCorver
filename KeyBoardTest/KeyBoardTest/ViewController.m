//
//  ViewController.m
//  KeyBoardTest
//
//  Created by CxDtreeg on 15/10/30.
//  Copyright © 2015年 CxDtreeg. All rights reserved.
//

#import "ViewController.h"

#import "UIViewController+KeyboardCorver.h"

@interface ViewController ()

@property (strong, nonatomic) UIScrollView * scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(0, 0, APPWINDOWWIDTH, APPWINDOWHEIGHT);
    _scrollView.contentSize = CGSizeMake(APPWINDOWWIDTH, 1000);
    _scrollView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_scrollView];
    
    UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(8,600 , APPWINDOWWIDTH-16, 40)];
    textField.backgroundColor = [UIColor grayColor];
    [_scrollView addSubview:textField];
    
    [self addNotification];
}

- (void)dealloc
{
    [self clearNotificationAndGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

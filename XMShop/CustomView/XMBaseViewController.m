//
//  XMBaseViewController.m
//  XMShop
//
//  Created by apple on 2018/3/9.
//  Copyright © 2018年 RM. All rights reserved.
//

#import "XMBaseViewController.h"
#import "LDNavBar.h"

@interface XMBaseViewController ()
@property (strong,nonatomic)LDNavBar *navBar;

@end

@implementation XMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setNavi];
    
}

- (void)setNavi{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBarHidden = YES;
    
    _navBar = [LDNavBar dc_viewFromXib];
    _navBar.title.text = @"";
    [_navBar.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [_navBar.settingBtn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    _navBar.frame = CGRectMake(0, DCStatusBarH, self.view.width, 44);
    [self.view addSubview:_navBar];
}

#pragma mark -  事件处理
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setting{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

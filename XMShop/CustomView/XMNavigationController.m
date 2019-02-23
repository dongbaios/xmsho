//
//  XMNavigationController.m
//  XMShop
//
//  Created by apple on 2018/3/9.
//  Copyright © 2018年 RM. All rights reserved.
//

#import "XMNavigationController.h"

@interface XMNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation XMNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
#pragma clang diagnostic pop
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    // 禁止使用系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
}
// 什么时候调用：每次触发手势之前都会询问下代理，是否触发。
// 作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    if (self.childViewControllers.count == 1) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    
    //左滑就不需要触发滑动手势
    CGPoint velocity = [gestureRecognizer velocityInView:gestureRecognizer.view];
    
    if(velocity.x>0)
        
    {
        
        return YES;
    }
    
    else
        
    {
        return NO;
        
    }
    

    return YES;
}

#pragma mark - 返回
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count >= 1) {
        //返回按钮自定义
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -15;
        
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(0, 0, 33, 33);
        
        if (@available(ios 11.0,*)) {
            button.contentEdgeInsets = UIEdgeInsetsMake(0, -15,0, 0);
            button.imageEdgeInsets = UIEdgeInsetsMake(0, -10,0, 0);
        }
        
        [button addTarget:self action:@selector(backButtonTapClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        viewController.navigationItem.leftBarButtonItems = @[negativeSpacer, backButton];
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 就有滑动返回功能
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    //跳转
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 点击
- (void)backButtonTapClick {
    
    [self popViewControllerAnimated:YES];
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

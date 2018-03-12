//
//  Macros.h
//  XMShop
//
//  Created by apple on 2018/3/8.
//  Copyright © 2018年 RM. All rights reserved.
//

#ifndef Macros_h
#define Macros_h
/** 屏幕高度 */
#define ScreenH [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度 */
#define ScreenW [UIScreen mainScreen].bounds.size.width

//导航栏+ 状态栏高度
#define DCTopNavH  iPhoneX ? 88.0 : 64.0
//状态栏高度
#define DCStatusBarH  iPhoneX ? 44.0 : 20.0
/** 弱引用 */
#define WEAKSELF __weak typeof(self) weakSelf = self;

/*****************  屏幕适配  ******************/
#define iphone6p (ScreenH == 763)
#define iphone6 (ScreenH == 667)
#define iphone5 (ScreenH == 568)
#define iphone4 (ScreenH == 480)
//判断设备是否为iphoneX
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]


#endif /* Macros_h */

//
//  LDMenuContentView.h
//  XMShop
//
//  Created by apple on 2018/3/7.
//  Copyright © 2018年 RM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickBlock) (NSInteger sender);
@interface LDMenuContentView : UIView
@property (nonatomic,strong)NSArray *data;
@property (copy,nonatomic)ClickBlock block;
@end

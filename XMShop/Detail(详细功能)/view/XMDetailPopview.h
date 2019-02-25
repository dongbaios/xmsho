//
//  XMDetailPopview.h
//  XMShop
//
//  Created by lidong on 2018/3/12.
//  Copyright © 2018年 RM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGoodModel;
@interface XMDetailPopview : UIView
@property (weak, nonatomic) IBOutlet UIButton *bottombtn;
/** 按钮回调 */
@property (copy,nonatomic) dispatch_block_t sellBlock;
@property (copy,nonatomic) dispatch_block_t buyBlock;
@property (copy,nonatomic) dispatch_block_t shareBlock;

/** 数据模型 */
@property (copy,nonatomic)XMGoodModel *model;
@end

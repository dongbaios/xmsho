//
//  XMGoodModel.h
//  XMShop
//
//  Created by lidong on 2019/2/23.
//  Copyright © 2019年 RM. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMContacts;
@interface XMGoodType : NSObject
/** 类别名称 */
@property (copy,nonatomic)NSString *typeName;
/** 类别id */
@property (assign,nonatomic)NSInteger typeId;
@end

@interface XMGoodModel : NSObject
/** 商品名称 */
@property (copy,nonatomic)NSString *goodName;
/** 商品图片 */
@property (strong,nonatomic)UIImage *image;
/** 商品类别 */
@property (assign,nonatomic)NSInteger typeId;
/** 售价 */
@property (assign,nonatomic)CGFloat sellPrice;
/** 收货人 (卖给了谁)*/
@property (strong,nonatomic)XMContacts *goodToP;
/** 进价 */
@property (assign,nonatomic)CGFloat buyPrice;
/** 供应商 （从哪进的货）*/
@property (strong,nonatomic)XMContacts *goodFromP;
/** 货号/条形码号 */
@property (copy,nonatomic)NSString *goodCode;
/** 单位规格（个，根，条。。。） */
@property (copy,nonatomic)NSString *goodUnit;
/** 库存量 */
@property (assign,nonatomic)NSInteger storeNum;
/** 商品描述 */
@property (copy,nonatomic)NSString *desc;

@end

//
//  XMContacts.h
//  XMShop
//
//  Created by lidong on 2019/2/23.
//  Copyright © 2019年 RM. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 联系人 */
@interface XMContacts : NSObject

/** 姓名 */
@property (copy,nonatomic)NSString *name;
/** 所属公司 店铺名称 */
@property (copy,nonatomic)NSString *companyName;
/** 联系电话 */
@property (copy,nonatomic)NSString *phoneNo;
/** 地址 */
@property (copy,nonatomic)NSString *address;
/** 欠款，正数为欠自己的钱，负数为自己欠他的钱 */
@property (assign,nonatomic)NSInteger character;


@end

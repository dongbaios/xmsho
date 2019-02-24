//
//  XMServiceViewController.h
//  XMShop
//
//  Created by lidong on 2019/2/24.
//  Copyright © 2019年 RM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMContacts;
@interface XMServiceViewController : UIViewController

@property (copy,nonatomic)void (^backBlock) (XMContacts *type);

@end

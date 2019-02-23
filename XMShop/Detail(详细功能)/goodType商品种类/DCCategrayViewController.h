//
//  DCCategrayViewController.h
//  CDDStoreDemo
//
//  Created by lidong on 2019/2/20.
//  Copyright © 2019年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGoodType;
@interface DCCategrayViewController : UIViewController
@property (copy,nonatomic)void (^backBlock) (XMGoodType *typeId);
@end

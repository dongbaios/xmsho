//
//  UIViewController+Alert.h
//  CDDStoreDemo
//
//  Created by lidong on 2019/2/21.
//  Copyright © 2019年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Alert)
-(UIAlertController *)showAlertWithTitle:(NSString *)title
                      Msg:(NSString *)msg
              BtnTitleArr:(NSArray *)btnTitleArr
                   Handle:(void (^)(UIAlertAction *action))handler
              OtherHandle:(void (^)(UIAlertAction *action))otherHandler;
@end

//
//  UIViewController+Alert.m
//  CDDStoreDemo
//
//  Created by lidong on 2019/2/21.
//  Copyright © 2019年 RocketsChen. All rights reserved.
//

#import "UIViewController+Alert.h"

@implementation UIViewController (Alert)
-(UIAlertController *)showAlertWithTitle:(NSString *)title
                      Msg:(NSString *)msg
              BtnTitleArr:(NSArray *)btnTitleArr
                   Handle:(void (^)(UIAlertAction *action))handler
              OtherHandle:(void (^)(UIAlertAction *action))otherHandler{
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:btnTitleArr.firstObject style:UIAlertActionStyleDefault handler:handler];
    [alter addAction:cancleAction];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:btnTitleArr.lastObject style:UIAlertActionStyleDefault handler:otherHandler];
    [alter addAction:okAction];
    
    return alter;
}
@end

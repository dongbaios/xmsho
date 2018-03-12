//
//  FTLabel.h
//  FTDataBase
//
//  Created by fyxj on 17/1/23.
//  Copyright © 2017年 fyxj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTLabel : UILabel {
    @private
    CGFloat _characterSpacing;       //字间距
}

@property(nonatomic,assign) CGFloat characterSpacing;

+ (FTLabel *)getLabelWithText:(NSString *)text textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize frame:(CGRect)frame;

+ (FTLabel *)getLabelWithLineSpace:(CGFloat)lineSpace text:(NSString *)text textColor:(UIColor *)color fontSize:(CGFloat)fontSize;


@end

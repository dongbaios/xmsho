//
//  FTLabel.m
//  FTDataBase
//
//  Created by fyxj on 17/1/23.
//  Copyright © 2017年 fyxj. All rights reserved.
//

#import "FTLabel.h"

@implementation FTLabel

@synthesize characterSpacing = _characterSpacing;

+ (FTLabel *)getLabelWithText:(NSString *)text textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize frame:(CGRect)frame {
    
    FTLabel *label = [[FTLabel alloc]init];
    label.text = text;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.frame = frame;
    return label;
}

+ (FTLabel *)getLabelWithLineSpace:(CGFloat)lineSpace text:(NSString *)text textColor:(UIColor *)color fontSize:(CGFloat)fontSize {
    FTLabel *label = [[FTLabel alloc]init];
    label.text = text;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:fontSize];
//    label.numberOfLines = 0;
    
    //设置行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:label.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, label.text.length)];
    label.attributedText = attributedString;
    
    return label;
}

@end

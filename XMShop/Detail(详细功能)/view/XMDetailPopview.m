//
//  XMDetailPopview.m
//  XMShop
//
//  Created by lidong on 2018/3/12.
//  Copyright © 2018年 RM. All rights reserved.
//

#import "XMDetailPopview.h"

@implementation XMDetailPopview
-(void)awakeFromNib{
    [super awakeFromNib];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.height = self.bottombtn.bottom + 26;
}
- (IBAction)close:(UIButton *)sender {
    [self dismissPopview];
}

@end

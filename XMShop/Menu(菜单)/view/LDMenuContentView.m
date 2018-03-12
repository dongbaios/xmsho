//
//  LDMenuContentView.m
//  XMShop
//
//  Created by apple on 2018/3/7.
//  Copyright © 2018年 RM. All rights reserved.
//

#import "LDMenuContentView.h"
#import "DCUpDownButton.h"
@implementation LDMenuContentView

-(void)setData:(NSArray *)data{
    _data = data;
    for (int i = 0; i < data.count; i++) {
        DCUpDownButton *btn = self.subviews[i];
        NSDictionary *dic = data[i];
        btn.hidden = NO;
        [btn setTitle: dic[@"title"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:dic[@"img"]] forState:UIControlStateNormal];
        
    }
}
- (IBAction)click:(UIButton *)sender {
    self.block(sender.tag);
}



@end

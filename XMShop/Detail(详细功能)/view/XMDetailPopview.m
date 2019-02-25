//
//  XMDetailPopview.m
//  XMShop
//
//  Created by lidong on 2018/3/12.
//  Copyright © 2018年 RM. All rights reserved.
//

#import "XMDetailPopview.h"
#import "XMGoodModel.h"

@interface BigerBtn : UIButton


@end
@implementation BigerBtn
/** 扩大点击范围 */
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    if(CGRectContainsPoint(CGRectInset(self.bounds, -50, -20), point)) {
        return YES;
    }
    return NO;
}

@end

@interface XMDetailPopview ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *barCode;
@property (weak, nonatomic) IBOutlet UILabel *storeNum;
@property (weak, nonatomic) IBOutlet UILabel *sellPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end


@implementation XMDetailPopview

#pragma mark - 视图相关
-(void)awakeFromNib{
    [super awakeFromNib];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.height = self.bottombtn.bottom + 26;
}

-(void)setModel:(XMGoodModel *)model{
    _model = model;
    self.imageView.image = model.image;
    self.nameLabel.text = model.goodName;
    self.storeNum.text = [NSString stringWithFormat:@"库存：%ld%@",model.storeNum,model.goodUnit];
    self.sellPriceLabel.text = [NSString stringWithFormat:@"%0.2lf元",model.sellPrice];
    self.buyPriceLabel.text = [NSString stringWithFormat:@"%0.2lf元",model.buyPrice];
    self.descLabel.text = model.desc;
}

#pragma mark - 超出范围事件处理
/** 遍历子视图，判断点击位置在是否某个子视图内，为了使子视图超出bounds后 点击也能有反应 */
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    //    NSLog(@"%s",__func__);
    BOOL flag = NO;
    for (UIView *view in self.subviews) {
        if (CGRectContainsPoint(view.frame, point)){
            flag = YES;
            break;
        }
    }
    return flag;
}


#pragma mark - 事件处理
- (IBAction)close:(UIButton *)sender {
    [self dismissPopview];
}

- (IBAction)sell:(UIButton *)sender {
    if (_sellBlock) _sellBlock();
}

- (IBAction)buy:(UIButton *)sender {
    if (_buyBlock) _buyBlock();
}

- (IBAction)share:(UIButton *)sender {
    if (_shareBlock) _shareBlock();
}



@end

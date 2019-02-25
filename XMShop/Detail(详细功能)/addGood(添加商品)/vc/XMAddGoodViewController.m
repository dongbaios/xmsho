//
//  XMAddGoodViewController.m
//  XMShop
//
//  Created by lidong on 2019/2/22.
//  Copyright © 2019年 RM. All rights reserved.
//

#import "XMAddGoodViewController.h"
#import "DCCategrayViewController.h"
#import "XMServiceViewController.h"

#import "XMGoodModel.h"
#import "XMContacts.h"

#import "BGDB.h"
@interface XMAddGoodViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *typeLable;
@property (weak, nonatomic) IBOutlet UITextField *SellPrice;
@property (weak, nonatomic) IBOutlet UITextField *buyPriceLable;
@property (weak, nonatomic) IBOutlet UITextField *barCode;
@property (weak, nonatomic) IBOutlet UITextField *goodUnit;
@property (weak, nonatomic) IBOutlet UITextField *storeNum;
@property (weak, nonatomic) IBOutlet UITextView *descripte;
@property (weak, nonatomic) IBOutlet UILabel *serviceName;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFieldArr;
/** 商品模型 */
@property (strong,nonatomic)XMGoodModel *goodModel;

@end

@implementation XMAddGoodViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSelector:@selector(showKeyBoard) withObject:nil afterDelay:0.75];
    self.goodModel = [XMGoodModel new];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    

    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  事件处理
- (void)showKeyBoard{
    [self.nameLable becomeFirstResponder];
}

/** 模型数据填充 */
- (IBAction)sureAdd:(UIButton *)sender {
    self.goodModel.goodName = self.nameLable.text;
    self.goodModel.image = [UIImage imageNamed:@"danju_icon"];
    self.goodModel.sellPrice = self.SellPrice.text.floatValue;
    self.goodModel.buyPrice = self.buyPriceLable.text.floatValue;
    self.goodModel.goodCode = self.barCode.text;
    self.goodModel.goodUnit = self.goodUnit.text;
    self.goodModel.storeNum = self.storeNum.text.integerValue;
    self.goodModel.desc = self.descripte.text;
    [self addGood];
}


/** 添加库存，添加商品到数据库 */
- (void)addGood{
    /**
    直接存储自定义对象.
    */
    
    self.goodModel.bg_tableName = xm_goodStoreTable;//自定义数据库表名称(库自带的字段).
    /**
     存储.
     */
    [SVProgressHUD show];
    [self.goodModel bg_saveAsync:^(BOOL isSuccess) {
        if (isSuccess) {
            [SVProgressHUD showSuccessWithStatus:@"添加成功"];
        }else{
            [SVProgressHUD showSuccessWithStatus:@"添加失败"];
        }
        
    }];
}

- (IBAction)addImage:(UIButton *)sender {
    
    
}

#pragma mark - textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSInteger idx = [_textFieldArr indexOfObject:textField];
    if (idx != 5) {
        
        [_textFieldArr[idx+1] becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}






#pragma mark - storyboard跳转
/** 跳转相关 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[DCCategrayViewController class]]) {
        WEAKSELF
        DCCategrayViewController *toVC = segue.destinationViewController;
        toVC.backBlock = ^(XMGoodType *type) {
            weakSelf.goodModel.typeId = type.typeId;
            weakSelf.typeLable.text = type.typeName;
        };
    }else if ([segue.destinationViewController isKindOfClass:[XMServiceViewController class]]){
        WEAKSELF
        XMServiceViewController *toVC = segue.destinationViewController;
        toVC.backBlock = ^(XMContacts *service) {
            weakSelf.goodModel.goodFromP = service;
            weakSelf.serviceName.text = service.companyName;
        };
    }
}

/**  去除按钮所在cell上面的分割线 */
-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
        
    
    for (UIView *view in cell.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"_UITableViewCellSeparatorView")]) {
            if (indexPath.section == 4) {
                view.hidden = YES;
            }else{
                view.hidden = NO;
            }
            
        }
    }
}

-(void)dealloc{
    
}

@end

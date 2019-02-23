//
//  XMAddGoodViewController.m
//  XMShop
//
//  Created by lidong on 2019/2/22.
//  Copyright © 2019年 RM. All rights reserved.
//

#import "XMAddGoodViewController.h"
#import "XMGoodModel.h"
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
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFieldArr;
/** 商品模型 */
@property (strong,nonatomic)XMGoodModel *goodModel;

@end

@implementation XMAddGoodViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.nameLable becomeFirstResponder];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    

    [self.view endEditing:YES];
}

#pragma mark -  事件处理
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sureAdd:(UIButton *)sender {
    self.goodModel = [XMGoodModel new];
    self.goodModel.goodName = self.nameLable.text;
    self.goodModel.image = [UIImage imageNamed:@"danju_icon"];
    XMGoodType *type = [XMGoodType new];
    type.typeName = @"鱼类";
    type.typeId = 1;
    self.goodModel.goodType = type;
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
    [self.goodModel bg_save];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


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

@end

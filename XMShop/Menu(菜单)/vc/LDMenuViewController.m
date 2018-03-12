//
//  LDMenuViewController.m
//  XMShop
//
//  Created by apple on 2018/3/7.
//  Copyright © 2018年 RM. All rights reserved.
//

#import "LDMenuViewController.h"
#import "UIView+Layout.h"
#import "LDHeaderView.h"
#import "LDMenuContentView.h"
#import "LDNavBar.h"
#import "XMStockViewController.h"
@interface LDMenuViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSArray *menuData;

@end

@implementation LDMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}

-(NSArray *)menuData{
    if (!_menuData) {
        NSArray *arr0 = @[
                          @{@"title":@"库存"
                            ,@"img":@"kucun_icon"
                            ,@"vc":@""},
                          @{@"title":@"客户管理"
                            ,@"img":@"kehu_icon"
                            ,@"vc":@""},
                          @{@"title":@"销售录单"
                            ,@"img":@"danju_icon"
                            ,@"vc":@""},
                          @{@"title":@"采购录单"
                            ,@"img":@"caigou_icon"
                            ,@"vc":@""},
                          @{@"title":@"业务单据"
                            ,@"img":@"yewudanju_icon"
                            ,@"vc":@""}
                          ];
        
        NSArray *arr1 =  @[
                           @{@"title":@"应收款"
                             ,@"img":@"shoukuan_icon"
                             ,@"vc":@""},
                           @{@"title":@"应付款"
                             ,@"img":@"fukuan_icon"
                             ,@"vc":@""},
                           @{@"title":@"账务明细"
                             ,@"img":@"zhangwu_icon"
                             ,@"vc":@""},
                           ];
        
        NSArray *arr2 =  @[
                           @{@"title":@"销售报表"
                             ,@"img":@"xiaoshoubaobiao_icon"
                             ,@"vc":@""},
                           @{@"title":@"热销商品"
                             ,@"img":@"rexiao_icon"
                             ,@"vc":@""},
                           @{@"title":@"采购月报"
                             ,@"img":@"caigouyuebao_icon"
                             ,@"vc":@""},
                           @{@"title":@"客户统计"
                             ,@"img":@"kehutongji"
                             ,@"vc":@""}
                           ];
        _menuData = @[arr0,arr1,arr2];
    }
    return _menuData;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
        _scrollView.pagingEnabled = YES;
        [_scrollView setContentSize:CGSizeMake(self.view.width *3, self.view.height)] ;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = 3;
    }
    return _pageControl;
}


- (void)initUI{
    self.view.backgroundColor = HEXCOLOR(0x323232);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBarHidden = YES;
    
    NSArray *titleArr = @[@"进销存",@"财务记账",@""];
    NSArray *colorArr = @[HEXCOLOR(0x2c5570),RGB(45, 45, 45),RGB(50, 50, 50)];
    for (int i = 0; i<3; i++) {
        UIView *backView = [UIView new];
        backView.frame = CGRectMake(i*ScreenW, 0, self.view.width, self.view.height);
        backView.backgroundColor = colorArr[i];
        [self.scrollView addSubview:backView];
        LDNavBar *navBar = [LDNavBar dc_viewFromXib];
        navBar.title.text = titleArr[i];
        [navBar.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [navBar.settingBtn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
        navBar.tag = i+100;
        navBar.frame = CGRectMake(i*self.view.width, DCStatusBarH, self.view.width, 44);
        [self.scrollView addSubview:navBar];
        
        
        LDHeaderView *header = [LDHeaderView dc_viewFromXib];
        header.tag = i+200;
        if (i == 1) {
            header.title.text = @"资金账户";
        }else if (i == 2){
            header.title.hidden = YES;
            header.imageV.hidden = YES;
            header.num.hidden = YES;
            header.bigTitle.hidden = NO;
        }
        header.frame = CGRectMake(i*self.view.width, navBar.bottom + 10, self.view.width, self.scrollView.height *0.2);
        [self.scrollView addSubview:header];
        
        
        LDMenuContentView * contenView = [LDMenuContentView dc_viewFromXib];
        contenView.data = self.menuData[i];
        contenView.tag = i+300;
        WEAKSELF
        contenView.block = ^(NSInteger sender) {
            [weakSelf goToDetail:sender];
        };
        contenView.frame = CGRectMake(header.x, header.bottom + 60, header.width, self.view.height *0.3);
        [self.scrollView addSubview:contenView];
    }
    self.pageControl.size =CGSizeMake(40, 40);
    self.pageControl.centerX = self.view.width*0.5;
    self.pageControl.y = self.view.height - 70 - 40;
    [self.view addSubview:self.pageControl];
    self.pageControl.currentPage = self.index;
    [self.scrollView setContentOffset:CGPointMake(self.index*self.view.width, 0) animated:NO];
    
}

#pragma mark - scrollview代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageControl.currentPage = scrollView.contentOffset.x / scrollView.width;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.x< - 60) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -  事件处理
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setting{
    
}

- (void)goToDetail:(NSInteger)index{
    XMStockViewController *vc =[XMStockViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

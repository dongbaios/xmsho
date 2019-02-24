//
//  LDHomeViewController.m
//  XMShop
//
//  Created by apple on 2018/3/7.
//  Copyright © 2018年 RM. All rights reserved.
//

#import "LDHomeViewController.h"
#import "UIView+Layout.h"
#import "iCarousel.h"
#import "LDHomeView.h"
#import "LDMenuViewController.h"
@interface LDHomeViewController ()<iCarouselDelegate,iCarouselDataSource>
@property (weak, nonatomic) IBOutlet iCarousel *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong,nonatomic)NSArray *dataArray;

@end

@implementation LDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@[@"销售",
                         @"jianxiake",
                         @"今天销售",
                         @"本月销售"],
                       @[@"财务",
                         @"xiaoyaosheng",
                         @"本月支出",
                         @"资金总额"],
                       @[@"报表",
                         @"longtaizi",
                         @"现金流出",
                         @"现金流入"]];
    }
    return _dataArray;
}

- (void)initUI{
    self.navigationController.navigationBarHidden = YES;
    _scrollView.pagingEnabled =YES;
    _scrollView.type =  iCarouselTypeLinear;
    _scrollView.delegate = self;
    _scrollView.dataSource = self;
    _scrollView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (nonnull UIView *)carousel:(nonnull iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    LDHomeView *cell = [LDHomeView dc_viewFromXib];
    cell.width = carousel.width*7/12.0;
    cell.titlelabel.text = self.dataArray[index][0];
    cell.imageView.image = [UIImage imageNamed:self.dataArray[index][1]];
    cell.subLabe1.text = self.dataArray[index][2];
    cell.subLabel2.text = self.dataArray[index][3];
    return cell;
    
}

- (NSInteger)numberOfItemsInCarousel:(nonnull iCarousel *)carousel { 
    return 3;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            return  NO;
        }
        case iCarouselOptionFadeMax:
        {
            if (carousel.type == iCarouselTypeCustom)
            {
                return 0.0f;
            }
            return value;
        }
        
        case iCarouselOptionSpacing:
        {
            return 1.3 *value;
        }
        default:
        {
            return value;
        }
    }
}

-(void)carouselDidEndDecelerating:(iCarousel *)carousel{
    self.pageControl.currentPage = self.scrollView.currentItemIndex;
}

-(void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    
    LDMenuViewController *vc = [LDMenuViewController new];
    vc.index = self.pageControl.currentPage;
    [self.navigationController pushViewController:vc animated:YES];
}


@end

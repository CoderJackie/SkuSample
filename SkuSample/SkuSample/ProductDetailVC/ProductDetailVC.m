//
//  ProductDetailVC.m
//  SkuSample
//
//  Created by xujiaqi on 15/6/26.
//  Copyright (c) 2015年 xujiaqi. All rights reserved.
//

#import "ProductDetailVC.h"
#import "ProductDetailModel.h"
#import "ProductDetailBuyAreaView.h"

static NSInteger const btnAccessoryViewTag = 213;

@interface ProductDetailVC() <ProductDetailBuyAreaViewDelegate>

///Sku选择器
@property (strong, nonatomic) ProductDetailBuyAreaView *productDetailBuyAreaView;

///商品详情model
@property (strong, nonatomic) ProductDetailModel *productDetailModel;

@end

@implementation ProductDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadLocalData];
}

- (void)loadLocalData
{
    NSString *file = [[NSBundle mainBundle] pathForResource:@"ProductData.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:file];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    ProductDetailModel *detailModel = [ProductDetailModel objectWithKeyValues:dict];
    self.productDetailModel = detailModel;
    
    [self.view addSubview:self.productDetailBuyAreaView];
    
    //sku选择器
    self.productDetailBuyAreaView.detailModel = self.productDetailModel;
    
}

#pragma mark - event response
- (IBAction)SkuClick
{
    CGFloat height = [self.productDetailBuyAreaView getHeight];
    
    [self addAccessoryView:height below:self.productDetailBuyAreaView];
    
    self.productDetailBuyAreaView.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.productDetailBuyAreaView.frame = CGRectMake(0, kAllHeight - height, kScreenWidth, height);
    }];
}

#pragma mark - ProductDetailBuyAreaViewDelegate

- (void)ProductDetailBuyAreaViewShowDidSelectCloseButton
{
    UIButton *btnAccessoryView = (UIButton *)[self.view viewWithTag:btnAccessoryViewTag];
    [self clickAccessoryAction:btnAccessoryView];
}

- (void)ProductDetailBuyAreaViewShowDidSelectComfirmButtonWithIntoCartModel:(IntoCartModel *)intoCartModel
{
    UIButton *btnAccessoryView = (UIButton *)[self.view viewWithTag:btnAccessoryViewTag];
    [self clickAccessoryAction:btnAccessoryView];
}
- (void)clickAccessoryAction:(UIButton *)sender
{
    [UIView animateWithDuration:0.2 animations:^{
        [sender removeFromSuperview];
        self.productDetailBuyAreaView.frame = CGRectMake(0, kAllHeight, kScreenWidth, 0);
    } completion:^(BOOL finished) {
        if (finished) {
            self.productDetailBuyAreaView.hidden = YES;
        }
    }];
}

- (void)addAccessoryView:(CGFloat)height below:(UIView *)view {
    UIButton *btnAccessoryView = (UIButton *)[self.view viewWithTag:btnAccessoryViewTag];
    if (!btnAccessoryView) {
        btnAccessoryView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        btnAccessoryView.tag = btnAccessoryViewTag;
        [btnAccessoryView setBackgroundColor:[UIColor blackColor]];
        [btnAccessoryView setAlpha:0.75f];
        [btnAccessoryView addTarget:self action:@selector(clickAccessoryAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view insertSubview:btnAccessoryView belowSubview:view];
}

#pragma mark - getters and setters
- (ProductDetailBuyAreaView *)productDetailBuyAreaView
{
    if (!_productDetailBuyAreaView) {
        _productDetailBuyAreaView = [[ProductDetailBuyAreaView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        _productDetailBuyAreaView.backgroundColor = [UIColor whiteColor];
        _productDetailBuyAreaView.hidden = YES;
        _productDetailBuyAreaView.delegate = self;
    }
    return _productDetailBuyAreaView;
}
@end

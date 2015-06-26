//
//  ItemDetailBuyArea.h
//  demo
//
//  Created by huamulou on 14-9-15.
//  Copyright (c) 2014年 alibaba. All rights reserved.
//  SKU选择器

#import <UIKit/UIKit.h>
#import "ItemDetailCommon.h"
#import "productBuyType.h"
@class ProductDetailModel;
@class IntoCartModel;


@protocol ProductDetailBuyAreaViewDelegate <NSObject>

- (void)ProductDetailBuyAreaViewShowDidSelectCloseButton;
- (void)ProductDetailBuyAreaViewShowDidSelectComfirmButtonWithIntoCartModel:(IntoCartModel *)intoCartModel;

@end

@interface ProductDetailBuyAreaView : UIView <ItemDetailCell>

@property (nonatomic, assign) id <ProductDetailBuyAreaViewDelegate> delegate;
///商品详情传进来的数据模型
@property (strong, nonatomic) ProductDetailModel *detailModel;

///点击购物车还是点击购买
@property (assign, nonatomic) ProductDetailBottomViewType productDetailBottomViewType;

///用户实际限购数
@property (assign, nonatomic) NSInteger userNumber;

///sku选择器选择后相关参数
@property (strong, nonatomic, readonly) IntoCartModel *intoCartModel;

@end

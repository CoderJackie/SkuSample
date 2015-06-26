//
//  IntoCartModel.h
//  HKMall
//
//  Created by xujiaqi on 15/6/4.
//  Copyright (c) 2015年 365sji. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "productBuyType.h"

@interface IntoCartModel : NSObject
//------------------------------方便从sku选择器传出数据------------------------------

@property (copy, nonatomic) NSString *productId;
@property (copy, nonatomic) NSString *resultSku;
@property (assign, nonatomic) NSInteger buyNumber;
@property (copy, nonatomic) NSString *skuText;
@property (copy, nonatomic) NSString *imageUrl;
@property (assign, nonatomic) CGFloat tradePrice;
@property (assign, nonatomic) NSInteger stock;

@property (nonatomic, assign) ProductDetailBottomViewType productDetailBottomViewType;
//---------------------------------------------------------------------------------------------

@end

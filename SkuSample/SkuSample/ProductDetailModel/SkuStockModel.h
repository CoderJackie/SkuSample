//
//  SkuStockModel.h
//  HKMall
//
//  Created by xujiaqi on 15/5/27.
//  Copyright (c) 2015年 Long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SkuStockModel : NSObject

///SKU编码000238570001
@property (copy, nonatomic) NSString *sku;
///库存
@property (assign, nonatomic) NSInteger stock;
///价格
@property (assign, nonatomic) CGFloat price;
///市场价
@property (assign, nonatomic) CGFloat marketPrice;

@end

//
//  ProductDetailModel.m
//  HKMall
//
//  Created by xujiaqi on 15/5/27.
//  Copyright (c) 2015年 Long. All rights reserved.
//

#import "ProductDetailModel.h"
#import "ProductImageModel.h"
#import "ProductCommentModel.h"
#import "MerchantModel.h"
#import "SkuItemsModel.h"
#import "SkuStockModel.h"

@implementation ProductDetailModel

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"productImageArray" : [ProductImageModel class],
             @"productCommentArray" : [ProductCommentModel class],
             @"merchant" : [MerchantModel class],
             @"skuItems" : [SkuItemsModel class],
             @"skuStock" : [SkuStockModel class]
             };
}

@end

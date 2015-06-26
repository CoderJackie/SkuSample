//
//  SkuItemsModel.h
//  HKMall
//
//  Created by xujiaqi on 15/5/27.
//  Copyright (c) 2015年 Long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SkuItemsModel : NSObject
/**
 values
	[
 {
 valueStr 展示文字  白色、黑色
 valueId  属性值ID,
 imgUrl   展示图片地址
 sku      SKU编码
 },
 */
///属性ID
@property (assign, nonatomic) NSInteger attributeId;
///属性名称
@property (copy, nonatomic) NSString *attributeName;
///图片或文字 true图片，false文字
@property (assign, nonatomic) BOOL isRelationImage;

@property (strong, nonatomic) NSArray *values;
@end

//
//  SkuItemValueModel.h
//  HKMall
//
//  Created by xujiaqi on 15/6/1.
//  Copyright (c) 2015年 365sji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SkuItemValueModel : NSObject

///展示文字  白色、黑色
@property (copy, nonatomic) NSString *valueStr;
///属性值ID
@property (assign, nonatomic) NSInteger valueId;
///展示图片地址
@property (copy, nonatomic) NSString *imgUrl;
///SKU编码
@property (copy, nonatomic) NSString *sku;

@end

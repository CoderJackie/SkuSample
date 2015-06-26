//
//  ProductImageModel.h
//  HKMall
//
//  Created by xujiaqi on 15/5/27.
//  Copyright (c) 2015年 Long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductImageModel : NSObject

///商品图片
@property (copy, nonatomic) NSString *imageUrl;
///大商品图片
@property (copy, nonatomic) NSString *bigImageUrl;

@end

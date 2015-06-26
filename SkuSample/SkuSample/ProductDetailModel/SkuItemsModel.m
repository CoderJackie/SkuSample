//
//  SkuItemsModel.m
//  HKMall
//
//  Created by xujiaqi on 15/5/27.
//  Copyright (c) 2015年 Long. All rights reserved.
//

#import "SkuItemsModel.h"
#import "SkuItemValueModel.h"

@implementation SkuItemsModel

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"values" : [SkuItemValueModel class],
             };
}

@end

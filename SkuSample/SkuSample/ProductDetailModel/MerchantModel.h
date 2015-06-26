//
//  MerchantModel.h
//  HKMall
//
//  Created by xujiaqi on 15/5/27.
//  Copyright (c) 2015年 Long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MerchantModel : NSObject

///商家ID
@property (assign, nonatomic) NSInteger merchantId;
///商家店铺logo
@property (copy, nonatomic) NSString *shopImg;
///商家名称
@property (copy, nonatomic) NSString *shopName;
///商家地址
@property (copy, nonatomic) NSString *shopAddress;
///电话
@property (assign, nonatomic) NSInteger shopPhone;

@end

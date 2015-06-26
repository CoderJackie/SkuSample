//
//  ProductDetailModel.h
//  HKMall
//
//  Created by xujiaqi on 15/5/27.
//  Copyright (c) 2015年 Long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDetailModel : NSObject

///商品ID
@property (assign, nonatomic) NSInteger productId;
///商品名称
@property (copy, nonatomic) NSString *productName;
///惠卡价格
@property (assign, nonatomic) CGFloat tradePrice;
///市场价格
@property (assign, nonatomic) CGFloat marketPrice;
///采购价
@property (assign, nonatomic) CGFloat purchasePrice;
///库存
@property (assign, nonatomic) NSInteger stock;
///商品推荐语
@property (copy, nonatomic) NSString *recommendWord;
///商品状态(0-正常，1已下架)
@property (assign, nonatomic) NSInteger statusType;
///邮费  0包邮，大于0为邮费
@property (assign, nonatomic) NSInteger ispostage;

///运费，服务器会返回完整字符串
@property (copy, nonatomic) NSString *postage;

///购买人数
@property (assign, nonatomic) NSInteger buyCount;
///是否提供发票
@property (assign, nonatomic) BOOL isProvideInvoices;
///sku描述文字，当skuitem数组为空时返回
@property (copy, nonatomic) NSString *extensionPropertiesText;
//-----------------------------------------最近的评论(评价)
///往期评价总数量
@property (copy, nonatomic) NSString *commentCount;
///商品总评论星级1-5
@property (assign, nonatomic) NSInteger averageCommentLevel;
///商品评论列表
@property (strong, nonatomic) NSArray *productCommentArray;
//-----------------------------------------最近的评论(评价)

//--------------------------------------------------------商家


///商品详情描述
@property (copy, nonatomic) NSString *introduction;
///商品规格参数
@property (copy, nonatomic) NSString *productparameter;
///商品售后服务
@property (copy, nonatomic) NSString *salesservice;
///单用户限购数量
@property (assign, nonatomic) NSInteger userNumber;
///是否关注(0-关注 1-未关注)
@property (assign, nonatomic) BOOL isRemind;
///商品提醒编号
@property (copy, nonatomic) NSString *remindId;
///商家信息
@property (strong, nonatomic) NSArray *merchant;

///sku上商品小图
@property (copy, nonatomic) NSString *productSmallImage;

///商品图片列表
@property (strong, nonatomic) NSArray *productImageArray;

//--------------------------------------------------------商家


//-------------------------------------------sku库存价格
///sku属性
@property (strong, nonatomic) NSArray *skuItems;

@property (strong, nonatomic) NSArray *skuStock;
//-------------------------------------------sku库存价格

///商品发布时间(时间戳)
@property (assign, nonatomic) NSInteger createDt;
///秒杀商品结束时间 (时间戳)
@property (assign, nonatomic) NSInteger endDt;
///服务器当前时间 (时间戳)
@property (assign, nonatomic) NSInteger serviceDt;
///是否特价 1是 0不是
@property (assign, nonatomic) BOOL isSpecial;

//-------------------------------------------sku库存价格


@end

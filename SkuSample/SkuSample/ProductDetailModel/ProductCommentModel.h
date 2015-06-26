//
//  ProductCommentModel.h
//  HKMall
//
//  Created by xujiaqi on 15/5/27.
//  Copyright (c) 2015年 Long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductCommentModel : NSObject

///评论ID
@property (assign, nonatomic) NSInteger commentId;
///当前评论内容
@property (copy, nonatomic) NSString *commentContent;
///惠信号【格式:非匿名显示8位，高于8为加省略号，匿名显示惠信号首字母+3个星号+惠信号未字母】
@property (copy, nonatomic) NSString *commentUser;
///当前评论星级 1-5
@property (assign, nonatomic) NSInteger commentLevel;
///当前评论时间(时间戳)
@property (assign, nonatomic) NSInteger commentDt;
///当前评论是否匿名 1-是 0-否
@property (assign, nonatomic) NSInteger isAnonymous;
///电话
@property (assign, nonatomic) NSInteger phone;

@end

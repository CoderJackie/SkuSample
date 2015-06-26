//
//  ProductCommentListModel.h
//  HKMall
//
//  Created by xujiaqi on 15/6/4.
//  Copyright (c) 2015年 365sji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductCommentListModel : NSObject

///商品总评论星级 1-5
@property (assign, nonatomic) CGFloat averageCommentLevel;
///评论model
@property (strong, nonatomic) NSArray *commentArray;

@end

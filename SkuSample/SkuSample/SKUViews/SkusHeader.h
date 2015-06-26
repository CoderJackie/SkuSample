//
//  SkusHeader.h
//  HKMall
//
//  Created by xujiaqi on 15/6/1.
//  Copyright (c) 2015年 365sji. All rights reserved.
//  尺码和颜色分类的View

#import <Foundation/Foundation.h>

@interface SkusHeader : UICollectionReusableView
@property(weak, nonatomic) IBOutlet UILabel *titleLable;
@property(nonatomic, retain) NSString *title;
@end

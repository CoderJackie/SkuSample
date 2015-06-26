//
//  SkusCell.h
//  HKMall
//
//  Created by xujiaqi on 15/6/1.
//  Copyright (c) 2015年 365sji. All rights reserved.
//  每个collectionCell（相当于分类的按钮）

#import <UIKit/UIKit.h>


typedef enum {
    SKUCELLON = 0,
    SKUCELLOFF,
    SKUCELLDISABLE
} SkusCellStaus;

@interface SkusCell : UICollectionViewCell

@property(nonatomic, copy) NSString *title;
@property(nonatomic, retain) IBOutlet UILabel *btnTitle;


@property(nonatomic, assign) SkusCellStaus cellStaus;

- (void)on;

- (void)off;
@end

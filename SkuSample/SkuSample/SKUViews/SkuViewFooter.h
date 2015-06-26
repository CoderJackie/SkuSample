//
//  SkuViewFooter.h
//  demo
//
//  Created by huamulou on 14-9-17.
//  Copyright (c) 2014年 alibaba. All rights reserved.
//  购买数量View

#import <UIKit/UIKit.h>

@interface SkuViewFooter : UICollectionReusableView
@property(weak, nonatomic) IBOutlet UIButton *reduceBtn;
@property(nonatomic, copy) BOOL (^reduceBtnCB)(NSInteger num);


@property(weak, nonatomic) IBOutlet UILabel *numLabel;

@property(nonatomic, copy) BOOL (^addBtnCB)(NSInteger num);
@property(weak, nonatomic) IBOutlet UIButton *addBtn;

@property (weak, nonatomic) IBOutlet UIView *btnsView;


- (void)setUp;

+ (CGFloat)getHeight;
@end

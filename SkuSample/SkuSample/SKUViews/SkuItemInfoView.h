//
//  SkuItemInfoView.h
//  HKMall
//
//  Created by xujiaqi on 15/6/1.
//  Copyright (c) 2015年 365sji. All rights reserved.
//  显示商品图片、描述、价格的View

#import <UIKit/UIKit.h>

@interface SkuItemInfoView : UIView
@property(weak, nonatomic) IBOutlet UIImageView *mainImage;
@property(weak, nonatomic) IBOutlet UILabel *titleLable;
@property(weak, nonatomic) IBOutlet UILabel *priceLable;
//@property(weak, nonatomic) IBOutlet UILabel *selectedLabel;
@property(weak, nonatomic) IBOutlet UILabel *stockLabel;


@property(nonatomic, retain) NSString *mainImageUrl;
@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *price;
//@property(nonatomic, retain) NSString *selected;
@property(nonatomic, retain) NSString *stock;

@property (copy, nonatomic) void (^closeBlock)();

- (CGFloat)getHeight;
- (IBAction)closeButtonClick;

@end

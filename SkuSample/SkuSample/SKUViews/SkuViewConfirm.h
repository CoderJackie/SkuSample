//
//  SkuViewConfirm.h
//  HKMall
//
//  Created by xujiaqi on 15/6/1.
//  Copyright (c) 2015年 365sji. All rights reserved.
//  确认购买View

#import <UIKit/UIKit.h>

@interface SkuViewConfirm : UIView
@property(weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property(nonatomic, copy) void (^confirmBtnCB)();

- (IBAction)confirmBtnClick:(id)sender;
+ (CGFloat)getHeight;
@end

//
//  SkuViewConfirm.m
//  HKMall
//
//  Created by xujiaqi on 15/6/1.
//  Copyright (c) 2015年 365sji. All rights reserved.
//

#import "SkuViewConfirm.h"
#define DEFAULT_CORNERRADIUS 2.5


#define  SKUVIEWCONFIRM_HEIGHT 44

@implementation SkuViewConfirm

- (void)setUp
{
    [_confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];

}

- (IBAction)confirmBtnClick:(id)sender
{
    if (_confirmBtnCB) {
        _confirmBtnCB();
    }
}

+ (CGFloat)getHeight
{
    return SKUVIEWCONFIRM_HEIGHT;
}


@end

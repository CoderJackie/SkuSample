//
//  SkuViewFooter.m
//  HKMall
//
//  Created by xujiaqi on 15/6/1.
//  Copyright (c) 2015年 365sji. All rights reserved.
//

#import "SkuViewFooter.h"
#import "UIView+nib.h"
#import "ItemDetailCommon.h"

#define DEFAULT_CORNERRADIUS 2.5

#define SKUFOOTER_HEIGHT 59

@implementation SkuViewFooter

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [UIView viewFromNibWithFileName:@"SKUView" owner:self index:4];
    }

    return self;
}

- (void)setUp
{
    _reduceBtn.layer.borderWidth = VIEW_BORDERWIDTH;
    _reduceBtn.layer.masksToBounds = YES;
    [_reduceBtn addTarget:self action:@selector(reduceBtnClick:) forControlEvents:UIControlEventTouchUpInside];


    _addBtn.layer.borderWidth = VIEW_BORDERWIDTH;
    _addBtn.layer.masksToBounds = YES;
    [_addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    _numLabel.layer.masksToBounds = YES;


    _btnsView.layer.borderWidth= VIEW_BORDERWIDTH;
    _btnsView.layer.cornerRadius= DEFAULT_CORNERRADIUS;
    _btnsView.layer.masksToBounds= YES;

}

- (NSInteger)getNum {
    return _numLabel.text.integerValue;
}

- (void)reduceBtnClick:(id)sender {

    NSInteger num = [self getNum];
    NSInteger numTmp = num - 1;
    if (_reduceBtnCB && _reduceBtnCB(numTmp)) {
        if (numTmp < 1) {
            return;
        }
        if (numTmp == 1) {
            _reduceBtn.enabled = NO;
        }
        _numLabel.text = [NSString stringWithFormat:@"%@", @(numTmp)];
    }
}

- (void)addBtnClick:(id)sender {
    NSInteger num = [self getNum];
    NSInteger numTmp = num + 1;
    if (_addBtnCB && _addBtnCB(numTmp)) {
        if (numTmp > 0) {
            _reduceBtn.enabled = YES;
        }

        _numLabel.text = [NSString stringWithFormat:@"%@", @(numTmp)];
    }
}


+ (CGFloat)getHeight {
    return SKUFOOTER_HEIGHT;
}

@end

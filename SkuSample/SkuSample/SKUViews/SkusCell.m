//
//  SkusCell.m
//  HKMall
//
//  Created by xujiaqi on 15/6/1.
//  Copyright (c) 2015年 365sji. All rights reserved.
//
#import "SkusCell.h"
#import "UIView+nib.h"
#import "ItemDetailCommon.h"
#import "NSString+Extend.h"

#define VIEW_HEIGHTLIGHT_BORDERWIDTH 1
#define VIEW_THEME_COLOR  [UIColor colorWithRed:247/255.0f green:123/255.0f blue:159/255.0f alpha:1]
#define DEFAULT_CORNERRADIUS 2.5

@implementation SkusCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [UIView viewFromNibWithFileName:@"SKUView" owner:self index:3];
    }
    
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.btnTitle.attributedText = [title attributedStringWithChineseFontSize:12 withNumberAndLetterFontSize:12];
    self.btnTitle.textColor = [UIColor blackColor];
    self.layer.cornerRadius = DEFAULT_CORNERRADIUS;
    [self off];
    [self.btnTitle setNeedsDisplay];
    self.layer.masksToBounds = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _btnTitle.frame = self.contentView.bounds;
}

- (void)setCellStaus:(SkusCellStaus)cellStaus {
    _cellStaus = cellStaus;
    
    
    switch (cellStaus) {
        case SKUCELLON: {
            [self on];
            break;
        }
        case SKUCELLOFF: {
            [self off];
            break;
        }
        case SKUCELLDISABLE: {
            [self disable];
            break;
        }
        default:
            break;
    }
}


- (void)on { 
    self.btnTitle.textColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor redColor];
    self.layer.borderColor = VIEW_THEME_COLOR.CGColor;
    self.layer.borderWidth = VIEW_HEIGHTLIGHT_BORDERWIDTH;
}

- (void)off
{
    self.btnTitle.textColor = [UIColor blackColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = VIEW_BORDERWIDTH;
}

- (void)disable
{
    self.layer.borderWidth = VIEW_BORDERWIDTH;
}


@end
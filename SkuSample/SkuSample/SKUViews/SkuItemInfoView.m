//
//  SkuItemInfoView.m
//  HKMall
//
//  Created by xujiaqi on 15/6/1.
//  Copyright (c) 2015年 365sji. All rights reserved.
//

#import "SkuItemInfoView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+Extend.h"

#define YUAN  @"￥"
@implementation SkuItemInfoView

- (void)awakeFromNib
{
    self.mainImage.layer.borderWidth = 3.0;
    self.mainImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.mainImage.layer.cornerRadius = 5.0;
    self.mainImage.layer.masksToBounds = YES;
}

- (CGFloat)getHeight {

    return self.frame.size.height;
}

- (IBAction)closeButtonClick
{
    if (_closeBlock) {
        _closeBlock();
    }
}


- (void)setMainImageUrl:(NSString *)mainImageUrl {
    _mainImageUrl = mainImageUrl;
    [_mainImage sd_setImageWithURL:[NSURL URLWithString:_mainImageUrl] placeholderImage:[UIImage imageNamed:@"product_icon_placeHolder"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLable.text = title;
}

- (void)setPrice:(NSString *)price {
    _price = price;
    _priceLable.attributedText = [[NSString stringWithFormat:@"%@%@", YUAN, price] attributedStringWithChineseFontSize:14 withNumberAndLetterFontSize:14];
    CGFloat textWidth = [_priceLable.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) withTextFont:_priceLable.font withLineSpacing:0].width;
    _priceLable.frame = CGRectMake(_priceLable.frame.origin.x, _priceLable.frame.origin.y, textWidth, _priceLable.frame.size.height);
    _stockLabel.frame = CGRectMake(CGRectGetMaxX(_priceLable.frame), _stockLabel.frame.origin.y, _stockLabel.frame.size.width, _stockLabel.frame.size.height);
}

//- (void)setSelected:(NSString *)selected {
//    _selected = selected;
//    _selectedLabel.attributedText = [[NSString stringWithFormat:@"%@%@", @"", selected] attributedStringWithChineseFontSize:12 withNumberAndLetterFontSize:12];
//}

- (void)setStock:(NSString *)stock {
    _stock = stock;
    NSString *sttext = [NSString stringWithFormat:@"%@%@%@", @"（库存", stock, @"件）"];
    _stockLabel.attributedText = [sttext attributedStringWithChineseFontSize:12 withNumberAndLetterFontSize:12];
    CGFloat textWidth = [sttext boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) withTextFont:_priceLable.font withLineSpacing:0].width;
    _stockLabel.frame = CGRectMake(CGRectGetMaxX(_priceLable.frame), _stockLabel.frame.origin.y, textWidth, _stockLabel.frame.size.height);
}


@end

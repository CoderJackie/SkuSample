//
//  NSString+Extend.h
//  demo
//
//  Created by huamulou on 14-9-26.
//  Copyright (c) 2014年 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Extend)

- (CGFloat)widthWithFont:(UIFont *)font;

- (CGSize)boundingRectWithSize:(CGSize)size
                  withTextFont:(UIFont *)font
               withLineSpacing:(CGFloat)lineSpacing;

//sting转AttributedString
- (NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font;

- (CGFloat)heightOfFont:(UIFont *)font;

- (NSMutableAttributedString *)attributedStringWithChineseFontSize:(NSInteger)cfontSize
                                       withNumberAndLetterFontSize:(NSInteger)nlFontSize
                                                   withLineSpacing:(CGFloat)lineSpacing;


- (NSMutableAttributedString *)attributedStringWithChineseFont:(UIFont *)cfont
                                       withNumberAndLetterFont:(UIFont *)nlFont
                                               withLineSpacing:(CGFloat)lineSpacing;

- (CGSize)getRectSizeOfStringWithFontSize:(NSInteger)fontSize withLineSpacing:(CGFloat)lineSpacing;


- (CGSize)getRectSizeOfStringWithFontSize:(NSInteger)fontSize withLineSpacing:(CGFloat)lineSpacing withBoundingRect:(CGSize)rect;

- (NSMutableAttributedString *)attributedStringWithChineseFontSize:(NSInteger)cfontSize
                                       withNumberAndLetterFontSize:(NSInteger)nlFontSize;


- (CGSize)getRectSizeOfStringWithFontSize:(NSInteger)fontSize;


- (NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
                                                 withLineSpacing:(CGFloat)lineSpacing;
@end

//
//  NSString+Extend.m
//  demo
//
//  Created by huamulou on 14-9-26.
//  Copyright (c) 2014年 alibaba. All rights reserved.
//

#import "NSString+Extend.h"


@implementation NSString (Extend)


- (CGSize)getRectSizeOfStringWithFontSize:(NSInteger)fontSize withLineSpacing:(CGFloat)lineSpacing withBoundingRect:(CGSize)rect {
    NSMutableAttributedString *attributedText = [self attributedStringWithChineseFontSize:fontSize
                                                              withNumberAndLetterFontSize:fontSize
                                                                          withLineSpacing:lineSpacing];


    CGRect rect1 = [attributedText boundingRectWithSize:rect options:NSStringDrawingUsesLineFragmentOrigin context:nil];

    return rect1.size;

}

- (CGSize)getRectSizeOfStringWithFontSize:(NSInteger)fontSize {
    return [self getRectSizeOfStringWithFontSize:fontSize withLineSpacing:0 withBoundingRect:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
}

- (CGSize)getRectSizeOfStringWithFontSize:(NSInteger)fontSize withLineSpacing:(CGFloat)lineSpacing {
    return [self getRectSizeOfStringWithFontSize:fontSize withLineSpacing:lineSpacing withBoundingRect:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
}

- (NSMutableAttributedString *)attributedStringWithChineseFontSize:(NSInteger)cfontSize
                                       withNumberAndLetterFontSize:(NSInteger)nlFontSize {

    return [self attributedStringWithChineseFontSize:cfontSize withNumberAndLetterFontSize:nlFontSize withLineSpacing:0];
}


- (NSMutableAttributedString *)attributedStringWithChineseFontSize:(NSInteger)cfontSize
                                       withNumberAndLetterFontSize:(NSInteger)nlFontSize
                                                   withLineSpacing:(CGFloat)lineSpacing {

    if ([self length] > 0) {

        UIFont *cFont = [UIFont fontWithName:@"STHeitiSC-Light" size:cfontSize];
        UIFont *nlFont;
        if (nlFontSize >= 48) {
            nlFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:nlFontSize];
        } else {
            nlFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:nlFontSize];
        }
        return [self attributedStringWithChineseFont:cFont withNumberAndLetterFont:nlFont withLineSpacing:lineSpacing];

    }
    return nil;
}


- (NSMutableAttributedString *)attributedStringWithChineseFont:(UIFont *)cfont
                                       withNumberAndLetterFont:(UIFont *)nlFont
                                               withLineSpacing:(CGFloat)lineSpacing {

    if ([self length] > 0) {
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self];
        int typeChinese = 1;
        int typeOther = 2;
        int lastType = -1;
        int lastTypeIndex = -1;

        int typeNow;
        void (^addAttribute)(NSInteger type, NSInteger rangeStart, NSInteger length) = ^(NSInteger type, NSInteger rangeStart, NSInteger length) {
            if (type == typeChinese) {
                [attributedStr addAttributes:@{NSFontAttributeName : cfont} range:NSMakeRange(rangeStart, length)];
            } else {
                [attributedStr addAttributes:@{NSFontAttributeName : nlFont} range:NSMakeRange(rangeStart, length)];
            }
            //  NSLog(@"type = %i rangeStart = %i length = %i attribute %@",type,rangeStart,length, attributedStr);

        };
        for (int i = 0; i < [self length]; i++) {
            //NSString *s = [self substringWithRange:NSMakeRange(i, 1)];

            int a = [self characterAtIndex:i];
            //   NSLog(@"current is %@ , is chinese : %@", [self substringWithRange:NSMakeRange(i, 1)], ((a > 0x4e00 && a < 0x9fff) ? @"YES" : @"NO"));
            if (a > 0x4e00 && a < 0x9fff) {
                typeNow = typeChinese;
            } else {
                typeNow = typeOther;
            }
            if (lastType == -1) {
                lastType = typeNow;
                lastTypeIndex = i;
                continue;
            }

            if (typeNow == lastType) {
                if (i == [self length] - 1) {
                    addAttribute(typeNow, lastTypeIndex, i - lastTypeIndex + 1);
                }
                continue;
            } else {
                addAttribute(lastType, lastTypeIndex, i - lastTypeIndex);
                lastTypeIndex = i;
                lastType = typeNow;
                if (i == [self length] - 1) {
                    addAttribute(typeNow, lastTypeIndex, 1);
                }
                continue;
            }

        }

        if (lineSpacing > 0) {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:lineSpacing];

            [attributedStr addAttribute:NSParagraphStyleAttributeName
                                  value:paragraphStyle
                                  range:NSMakeRange(0, [self length])];
        }

        return attributedStr;
    }
    return nil;
}


- (NSMutableAttributedString *)attributedStringFromStingWithFont:(UIFont *)font
                                                 withLineSpacing:(CGFloat)lineSpacing {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName : font}];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];

    [attributedStr addAttribute:NSParagraphStyleAttributeName
                          value:paragraphStyle
                          range:NSMakeRange(0, [self length])];
    return attributedStr;
}

- (CGSize)boundingRectWithSize:(CGSize)size
                  withTextFont:(UIFont *)font
               withLineSpacing:(CGFloat)lineSpacing {
    NSMutableAttributedString *attributedText = [self attributedStringFromStingWithFont:font
                                                                        withLineSpacing:lineSpacing];
    CGSize textSize = [attributedText boundingRectWithSize:size
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil].size;
    return textSize;
}


- (CGFloat)widthWithFont:(UIFont *)font {
    CGSize maximumSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    return [self boundingRectWithSize:maximumSize withTextFont:font withLineSpacing:0].width;
}

- (CGFloat)heightOfFont:(UIFont *)font {
    CGSize maximumSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    CGSize size = [self boundingRectWithSize:maximumSize withTextFont:font withLineSpacing:0];
    return size.height;

}

@end

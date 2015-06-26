//
//  SkusHeader.m
//  HKMall
//
//  Created by xujiaqi on 15/6/1.
//  Copyright (c) 2015年 365sji. All rights reserved.
//

#import "SkusHeader.h"
#import "UIView+nib.h"

@implementation SkusHeader


- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLable.text = title;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [UIView viewFromNibWithFileName:@"SKUView" owner:self index:2];
    }

    return self;
}

@end

//
//  SkusFooter.m
//  HKMall
//
//  Created by xujiaqi on 15/6/1.
//  Copyright (c) 2015年 365sji. All rights reserved.
//

#import "SkusFooter.h"
#import "UIView+nib.h"

@implementation SkusFooter
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [UIView viewFromNibWithFileName:@"SKUView" owner:self index:1];
    }

    return self;
}
@end

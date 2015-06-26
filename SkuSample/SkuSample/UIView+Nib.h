//
//  UIView+Nib.h
//  SkuSample
//
//  Created by xujiaqi on 15/6/26.
//  Copyright (c) 2015年 xujiaqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Nib)
+ (id)viewFromNibWithFileName:(NSString *)file class:(Class)clasz index:(NSInteger)index;
+ (id)viewFromNibWithFileName:(NSString *)file owner:(id)owner index:(NSInteger)index;
@end

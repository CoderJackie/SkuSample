//
//  UIView+Nib.m
//  SkuSample
//
//  Created by xujiaqi on 15/6/26.
//  Copyright (c) 2015年 xujiaqi. All rights reserved.
//

#import "UIView+Nib.h"

@implementation UIView (Nib)
+ (id)viewFromNibWithFileName:(NSString *)file class:(Class)clasz index:(NSInteger)index {
    id owner = [[clasz alloc] init];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:file owner:owner options:nil];
    UIView *view = [nib objectAtIndex:index];
    
    if ([view isKindOfClass:clasz]) {
        return view;
    }
    
    return nil;
}

+ (id)viewFromNibWithFileName:(NSString *)file owner:(id)owner index:(NSInteger)index {
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:file owner:owner options:nil];
    UIView *view = [nib objectAtIndex:index];
    
    return view;
}
@end

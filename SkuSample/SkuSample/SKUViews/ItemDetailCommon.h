//
//  ItemDetailCommon.h
//  demo
//
//  Created by huamulou on 14-9-15.
//  Copyright (c) 2014年 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>


#define DEFAULT_SPACE  10
#define VIEW_BORDERWIDTH 0.5
#define DEFAULT_SKU_CELL_WIDTH 60
#define DEFAULT_SKU_CELL_HEIGHT 28
#define DEFAULT_SKU_HEADER_HEIGHT 35
#define DEFAULT_SKU_FOOTER_HEIGHT 8
#define OTHER_SKU_FOOTER_HEIGHT 60 + DEFAULT_SPACE
#define DEFAULT_SKU_LINE_HEIGHT (DEFAULT_SKU_HEADER_HEIGHT + DEFAULT_SKU_CELL_HEIGHT +2 *DEFAULT_SPACE + DEFAULT_SKU_FOOTER_HEIGHT)
#define DEFAULT_SKU_LINE_HEIGHT1 (DEFAULT_SKU_HEADER_HEIGHT + DEFAULT_SKU_CELL_HEIGHT +2 *DEFAULT_SPACE + OTHER_SKU_FOOTER_HEIGHT)

@protocol ItemDetailCell

@required
- (CGFloat)getHeight;
@end

@interface ItemDetailCommon : UIView

@end

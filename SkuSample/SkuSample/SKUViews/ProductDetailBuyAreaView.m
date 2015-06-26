//
//  ItemDetailBuyArea.m
//  demo
//
//  Created by huamulou on 14-9-15.
//  Copyright (c) 2014年 alibaba. All rights reserved.
//


#import "ProductDetailBuyAreaView.h"
#import "SkuItemInfoView.h"
#import "UIView+nib.h"
#import "SkusHeader.h"
#import "SkusFooter.h"
#import "SkusCell.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "SkuViewFooter.h"
#import "SkuViewConfirm.h"

#import "ProductDetailModel.h"

#import "SkuItemsModel.h"
#import "SkuItemValueModel.h"
#import "SkuStockModel.h"

#import "IntoCartModel.h"

@interface ProductDetailBuyAreaView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property(nonatomic, retain) UIView *upperLine;
@property(nonatomic, retain) UIView *skuArea;
@property(nonatomic, retain) SkuItemInfoView *skuItemInfoView;
@property(nonatomic, retain) UICollectionView *collectionView;
@property(nonatomic, retain) SkuViewConfirm *skuViewConfirm;

@property(nonatomic, assign) CGFloat skuAreaViewHeight;

@property(nonatomic, assign) NSInteger numNow;
@property(nonatomic, assign) NSInteger numMax;

@property(nonatomic, retain) NSMutableDictionary *selectedRows;
@property(nonatomic, retain) NSMutableDictionary *validRows;

@property(nonatomic, copy) BOOL (^addBtnCB)(NSInteger num);
@property(nonatomic, copy) BOOL (^reduceCB)(NSInteger num);

@property (strong, nonatomic) NSMutableArray *allSkuArray;

@end

@implementation ProductDetailBuyAreaView

@synthesize intoCartModel = _intoCartModel;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
        [self addSubViewConstraintAndResetFrame];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.detailModel.skuItems) {
        return self.detailModel.skuItems.count;
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.detailModel.skuItems) {
        NSMutableArray *values = [self getValues:section];
        return values.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = [collectionView dequeueReusableCellWithReuseIdentifier:@"SkusCell" forIndexPath:indexPath];
    
    if (reusableview == nil) {
        reusableview = [UIView viewFromNibWithFileName:@"SKUView" class:[SkusCell class] index:2];
    }
    SkusCell *cell = (SkusCell *) reusableview;
    
    
    NSInteger section = indexPath.section;
    
    NSMutableArray *values = [self getValues:section];
    SkuItemValueModel *value = values[indexPath.item];
    NSString *name = value.valueStr;
    
    [cell setTitle:name];

    if ([[self.selectedRows objectForKey:@(indexPath.section)] containsObject:indexPath]) {
        [cell setCellStaus:SKUCELLON];
    }
    
//    else if ([self.validRows objectForKey:@(section)]) {
//        NSArray *array = [self.validRows objectForKey:@(section)];
//        if ([array count] > 0) {
//            
//        }
//    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SkusHeader" forIndexPath:indexPath];
        
        if (reusableview == nil) {
            reusableview = [UIView viewFromNibWithFileName:@"SKUView" class:[SkusHeader class] index:3];
        }
        SkusHeader *header = (SkusHeader *) reusableview;
        
        SkuItemsModel *itemModel = self.detailModel.skuItems[indexPath.section];
        NSString *title = itemModel.attributeName;
        
        header.titleLable.text = title;
        return reusableview;
    }
    else if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *reusableview;
        if (self.detailModel.skuItems) {
            if (indexPath.section == (self.detailModel.skuItems.count - 1)) {
                reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SkuViewFooter" forIndexPath:indexPath];
                SkuViewFooter *skuViewFooter = (SkuViewFooter *) reusableview;
                skuViewFooter.reduceBtnCB = _reduceCB;
                skuViewFooter.addBtnCB = _addBtnCB;
                skuViewFooter.numLabel.text = [NSString stringWithFormat:@"%@", @(_numNow)];
                [skuViewFooter setUp];
            } else {
                reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SkusFooter" forIndexPath:indexPath];
                
            }
            return reusableview;
        }
    }
    return nil;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *sectionKey = @(indexPath.section);
    
    if (![self.selectedRows objectForKey:sectionKey]) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [array addObject:indexPath];
        [self.selectedRows setObject:array forKey:sectionKey];
    } else {
        NSMutableArray *array = [self.selectedRows objectForKey:sectionKey];
        [array removeAllObjects];
        [array addObject:indexPath];
    }
    
    [self setProductImageWhenClickSkuItem:indexPath];
    
    NSString *resultSku =  [self getSkuIntersection];
    
    if (resultSku) {
        SkuStockModel *stockModel = [self getSkuStockModelWithResultSku:resultSku];
        NSInteger quantity = stockModel.stock;
        if (quantity) {
            _numMax = quantity;
            if (_numNow > _numMax) {
                _numNow = _numMax;
            }
        }
        _skuItemInfoView.stock = kIntToString(quantity);
        [self setDataOfSkuItemInfoView:stockModel];
        [self saveProductSkuInfoToIntoCartModel:stockModel];
    }
    
    [_collectionView reloadData];
    
    NSLog(@"%@", self.intoCartModel.resultSku);
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    UIEdgeInsets result = UIEdgeInsetsMake(DEFAULT_SPACE, DEFAULT_SPACE, DEFAULT_SPACE, DEFAULT_SPACE);
    return result;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *values = [self getValues:indexPath.section];
    SkuItemValueModel *value = values[indexPath.item];
    NSString *name = value.valueStr;
    float stringWidth = DEFAULT_SKU_CELL_WIDTH;
    if ([name length] > 2) {
        
        float tmpWidth = [name boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) withTextFont:[UIFont systemFontOfSize:12] withLineSpacing:0].width;
        tmpWidth += 2 * DEFAULT_SPACE;
        if (tmpWidth > stringWidth) {
            stringWidth = tmpWidth;
        }
        
    }
    return CGSizeMake(stringWidth, DEFAULT_SKU_CELL_HEIGHT);
}

// 定义左右cell的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return DEFAULT_SPACE;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (self.detailModel.skuItems) {
        return CGSizeMake(self.frame.size.width, DEFAULT_SKU_HEADER_HEIGHT);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (self.detailModel.skuItems) {
        if (section == (self.detailModel.skuItems.count - 1))
            return CGSizeMake(self.frame.size.width, OTHER_SKU_FOOTER_HEIGHT);
        else
            return CGSizeMake(self.frame.size.width, DEFAULT_SKU_FOOTER_HEIGHT);
    }
    return CGSizeZero;
}

#pragma mark - private method

- (void)initialData
{
    _numNow = 1;
    _numMax = -1;
    
    self.userNumber = self.detailModel.userNumber;
    NSInteger stock = self.detailModel.stock;
    BOOL isSpecial = self.detailModel.isSpecial;
    
    __block ProductDetailBuyAreaView *selfBlockRef = self;
    _reduceCB = ^(NSInteger num) {
        if (num < 1) {return NO;}
        selfBlockRef.numNow = num;
        return YES;
    };
    _addBtnCB = ^(NSInteger num) {
        if (num < 0) {
            return NO;
        }
        if (selfBlockRef.numMax > 0 && num > selfBlockRef.numMax) {
          return NO;
        }
        
        //为选择sku时，限制不能超过最大库存
        if (num > stock) {
            return NO;
        }
        
        if (isSpecial) {
            if (num > selfBlockRef.userNumber) {
                NSLog(@"最多只能买%@件", @(selfBlockRef.userNumber));
                return NO;
            }
        }

        selfBlockRef.numNow = num;
        return YES;
    };
}

- (void)addSubviews
{
    [self addSubview:self.upperLine];
    [self.skuArea addSubview:self.skuItemInfoView];
    [self.skuArea addSubview:self.collectionView];
    [self.skuArea addSubview:self.skuViewConfirm];
    [self addSubview:self.skuArea];
}

- (void)addSubViewConstraintAndResetFrame
{
    _skuAreaViewHeight = 0;
    
    CGFloat skuItemInfoViewHeight = [self.skuItemInfoView getHeight];
    
    [self.skuItemInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.skuArea).offset(0);
        make.height.equalTo(@(skuItemInfoViewHeight));
    }];
    
    _skuAreaViewHeight += skuItemInfoViewHeight;
    
    
    CGFloat skuPropsHeight = DEFAULT_SKU_LINE_HEIGHT1;
    CGFloat defaultSkuLineHeight = DEFAULT_SKU_LINE_HEIGHT;
    if (self.detailModel.skuItems.count <= 2) {
        skuPropsHeight += (self.detailModel.skuItems.count - 1) * defaultSkuLineHeight;
    } else {
        skuPropsHeight += defaultSkuLineHeight;
    }
    
    _skuAreaViewHeight += skuPropsHeight;
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.skuArea).offset(0);
        make.right.equalTo(self.skuArea).offset(0);
        make.top.equalTo(self.skuItemInfoView.mas_bottom).offset(0);
        make.height.equalTo(@(skuPropsHeight));
    }];
    
    
    CGFloat footHeight = [SkuViewConfirm getHeight];
    _skuAreaViewHeight += footHeight;
    
    [self.skuViewConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.skuArea).offset(0);
        make.right.equalTo(self.skuArea).offset(0);
        make.bottom.equalTo(self.skuArea.mas_bottom).offset(0);
        make.height.equalTo(@(footHeight));
    }];
    
    _skuArea.frame = CGRectMake(0, 0, kScreenWidth, _skuAreaViewHeight);
}
- (void)updateSubViewsConstraints
{
    _skuAreaViewHeight = 0;
    
    CGFloat skuPropsHeight = DEFAULT_SKU_LINE_HEIGHT1;
    CGFloat defaultSkuLineHeight = DEFAULT_SKU_LINE_HEIGHT;
    if (self.detailModel.skuItems.count <= 2) {
        skuPropsHeight += (self.detailModel.skuItems.count - 1) * defaultSkuLineHeight;
    } else {
        skuPropsHeight += defaultSkuLineHeight;
    }
    
    CGFloat skuItemInfoViewHeight = [self.skuItemInfoView getHeight];
    _skuAreaViewHeight += skuPropsHeight + skuItemInfoViewHeight;
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(skuPropsHeight));
    }];
    
    
    CGFloat footHeight = [SkuViewConfirm getHeight];
    _skuAreaViewHeight += footHeight;
    
    
    [self.skuViewConfirm mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(footHeight));
    }];
    
    _skuArea.frame = CGRectMake(0, 0, kScreenWidth, _skuAreaViewHeight);
}

//根据点击item得到的skuStockModel设置商品价格、库存
- (void)setDataOfSkuItemInfoView:(SkuStockModel *)skuStockModel
{
    self.intoCartModel.skuText = [self getSelectedSkuString];
    self.skuItemInfoView.price = kIntToString(skuStockModel.price);
    self.skuItemInfoView.stock = kIntToString(skuStockModel.stock);
}

- (void)setSkuItemDefault
{
    ProductDetailModel *detailModel = self.detailModel;
    self.skuItemInfoView.title = detailModel.productName;
    
    self.skuItemInfoView.mainImageUrl = detailModel.productSmallImage;
    self.skuItemInfoView.price = kIntToString(detailModel.tradePrice);
    self.skuItemInfoView.stock = kIntToString(detailModel.stock);
}


- (CGFloat)getHeight {
    if (self.detailModel.skuItems.count) {
        return self.skuAreaViewHeight;
    } else {
        return 0;
    }
}

#pragma mark - 保存相关购买信息到intoCartModel
- (void)saveProductSkuInfoToIntoCartModel:(SkuStockModel *)skuStockModel
{
    self.intoCartModel.tradePrice = skuStockModel.price;
    self.intoCartModel.stock = skuStockModel.stock;
}

#pragma mark - sku数据相关处理
- (NSMutableArray *)getValues:(NSInteger)section {
    
    SkuItemsModel *itemModel = self.detailModel.skuItems[section];
    return [itemModel.values mutableCopy];
}

///取sku的交集
- (NSString *)getSkuIntersection
{
    [self.allSkuArray removeAllObjects];

    for (NSMutableArray *array in self.selectedRows.allValues) {
        if (array && ([array isKindOfClass:[NSMutableArray class]] || [array isKindOfClass:[NSArray class]])) {
            for (NSIndexPath *indexPath in array) {
                NSString *sku = [self getSkuPvWithIndexPath:indexPath];
                NSArray *array = [sku componentsSeparatedByString:@","];
                NSMutableSet *set = [NSMutableSet setWithArray:array];
                [self.allSkuArray addObject:set];
            }
        }
    }
    
    NSMutableSet *resultSet;
    if (self.allSkuArray.count) {
        resultSet = self.allSkuArray[0];
    }
    
    [self.allSkuArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if (idx != 0 && ([obj isKindOfClass:[NSMutableSet class]] || [obj isKindOfClass:[NSSet class]])) {
            [resultSet intersectSet:obj];
        }
        
    }];
    
    if (resultSet.count == 1) {
        id resultObject = [resultSet anyObject];
        if ([resultObject isKindOfClass:[NSString class]]) {
            self.intoCartModel.resultSku = resultObject;
        }
    }
    
    return self.intoCartModel.resultSku;
}

///根据求交集算出来的sku找到该sku对应的库存StockModel
- (SkuStockModel *)getSkuStockModelWithResultSku:(NSString *)resultSku
{
    __block SkuStockModel *resultModel;
    [self.detailModel.skuStock enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[SkuStockModel class]]) {
            SkuStockModel *stockModel = (SkuStockModel *)obj;
            if ([stockModel.sku isEqualToString:resultSku]) {
                resultModel = stockModel;
            }
        }
    }];
    
    return resultModel;
}

///取到indexPath对应的sku
- (NSString *)getSkuPvWithIndexPath:(NSIndexPath *)indexPath {
    SkuItemsModel *itemModel = self.detailModel.skuItems[indexPath.section];
    SkuItemValueModel *valueModel = itemModel.values[indexPath.row];
    NSString *sku = valueModel.sku;
    return sku;
}

///得到用户选择的分类（如颜色：黑色）
- (NSString *)getSelectedSkuString
{
    NSMutableString *selectedSkuString = [NSMutableString stringWithString:@""];
    
    [self.selectedRows enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSMutableArray class]]) {
            NSArray *array = (NSArray *)obj;
            [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if ([obj isKindOfClass:[NSIndexPath class]]) {
                    NSIndexPath *indexPath = (NSIndexPath *)obj;
                    
                    NSString *singleSkuString = @"";
                    
                    SkuItemsModel *itemModel = self.detailModel.skuItems[indexPath.section];
                    SkuItemValueModel *valueModel = itemModel.values[indexPath.row];
                    singleSkuString = [singleSkuString stringByAppendingFormat:@"%@:%@  ", itemModel.attributeName, valueModel.valueStr];
                    
                    [selectedSkuString appendString:singleSkuString];
                }
            }];
        };
    }];
    
    NSLog(@"%@", selectedSkuString);
    return selectedSkuString;
}

///获得所有行的attributeName（暂时无用）
- (NSString *)getAllSkuAttributeName
{
    NSMutableString *skuItemAttributeString = [NSMutableString stringWithString:@"请选择"];
    [self.detailModel.skuItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        SkuItemsModel *itemModel = (SkuItemsModel *)obj;
        [skuItemAttributeString appendFormat:@" %@",itemModel.attributeName];
    }];
    return skuItemAttributeString;
}

///获得未点击行的attributeName（如 尺寸、颜色），用户提示用户未选择哪一行
- (NSString *)getUnSelectedSkuString
{
    //有那几行被选中
    NSArray *selectedRows = self.selectedRows.allKeys;
    
    NSMutableArray *allRows = [NSMutableArray arrayWithCapacity:self.detailModel.skuItems.count];
    
    [self.detailModel.skuItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [allRows addObject:@(idx)];
    }];
    
    [selectedRows enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [allRows removeObject:obj];
    }];
    
    NSMutableString *unSelectedSkuString = [NSMutableString stringWithFormat:@""];
    [allRows enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSInteger index = [obj integerValue];
        SkuItemsModel *itemModel = self.detailModel.skuItems[index];
        
        [unSelectedSkuString appendFormat:@" %@", itemModel.attributeName];
    }];
    
    return unSelectedSkuString;
}

#pragma mark - event response

#pragma mark 点击确定按钮

- (void)skuViewConfirmClicked
{
    NSString *skuAttributeString = [self getUnSelectedSkuString];

    if (self.detailModel.skuItems.count == self.selectedRows.count) {//选择完毕
        SkuStockModel *stockModel = [self getSkuStockModelWithResultSku:self.intoCartModel.resultSku];
        if (stockModel.stock) {
            [self notifiedProductDetailVC];
        } else {
            NSLog(@"该商品暂时无库存");
        }
    } else {
        NSLog(@"请选择 %@", skuAttributeString);
    }
}

- (void)notifiedProductDetailVC
{
    self.intoCartModel.buyNumber = self.numNow;
    if ([self.delegate respondsToSelector:@selector(ProductDetailBuyAreaViewShowDidSelectComfirmButtonWithIntoCartModel:)]) {
        [self.delegate ProductDetailBuyAreaViewShowDidSelectComfirmButtonWithIntoCartModel:self.intoCartModel];
    }
}

///当选择颜色时设置商品图片
- (void)setProductImageWhenClickSkuItem:(NSIndexPath *)indexPath
{
    SkuItemsModel *skuItemModel = self.detailModel.skuItems[indexPath.section];
    NSString *imageURL = nil;
    
    if (skuItemModel.isRelationImage) {
        SkuItemValueModel *value = skuItemModel.values[indexPath.row];
        if (value.imgUrl) {
            imageURL = value.imgUrl;
        } else {
            imageURL = self.detailModel.productSmallImage;
        }
        [self.skuItemInfoView.mainImage sd_setImageWithURL:[NSURL URLWithString:value.imgUrl]];
    } else {
        self.intoCartModel.imageUrl = self.detailModel.productSmallImage;
    }
}

#pragma mark - getters and setters

- (UIView *)upperLine
{
    if (!_upperLine) {
        _upperLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, VIEW_BORDERWIDTH)];
        _upperLine.backgroundColor = [UIColor blackColor];
        _upperLine.alpha = 0.25;
    }
    return _upperLine;
}

- (UIView *)skuArea
{
    if (!_skuArea) {
        _skuArea = [[UIView alloc] init];
    }
    return _skuArea;
}

- (SkuItemInfoView *)skuItemInfoView
{
    if (!_skuItemInfoView) {
        _skuItemInfoView = [UIView viewFromNibWithFileName:@"SKUView" class:[SkuItemInfoView class] index:0];
        _skuItemInfoView.translatesAutoresizingMaskIntoConstraints = NO;
        kSelfWeak;
        _skuItemInfoView.closeBlock = ^ () {
            kSelfStrong;
            if ([strongSelf.delegate respondsToSelector:@selector(ProductDetailBuyAreaViewShowDidSelectCloseButton)]) {
                [strongSelf.delegate ProductDetailBuyAreaViewShowDidSelectCloseButton];
            }
        };
    }
    return _skuItemInfoView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
        layout.headerReferenceSize = CGSizeMake(self.frame.size.width, DEFAULT_SKU_HEADER_HEIGHT);
        layout.footerReferenceSize = CGSizeMake(self.frame.size.width, DEFAULT_SKU_FOOTER_HEIGHT);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerClass:[SkusCell class] forCellWithReuseIdentifier:@"SkusCell"];
        [_collectionView registerClass:[SkusHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SkusHeader"];
        [_collectionView registerClass:[SkusFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SkusFooter"];
        [_collectionView registerClass:[SkuViewFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SkuViewFooter"];
        _collectionView.backgroundColor = [UIColor clearColor];

    }
    return _collectionView;
}

- (SkuViewConfirm *)skuViewConfirm
{
    if (!_skuViewConfirm) {
        _skuViewConfirm = [UIView viewFromNibWithFileName:@"SKUView" class:[SkuViewConfirm class] index:5];
        _skuViewConfirm.translatesAutoresizingMaskIntoConstraints = NO;
        
        kSelfWeak;
        _skuViewConfirm.confirmBtnCB = ^{
            kSelfStrong;
            [strongSelf skuViewConfirmClicked];
        };
        
    }
    return _skuViewConfirm;
}

- (NSMutableArray *)allSkuArray
{
    if (!_allSkuArray) {
        _allSkuArray = [NSMutableArray array];
    }
    return _allSkuArray;
}

- (IntoCartModel *)intoCartModel
{
    if (!_intoCartModel) {
        _intoCartModel = [[IntoCartModel alloc] init];
    }
    return _intoCartModel;
}

- (NSMutableDictionary *)selectedRows
{
    if (!_selectedRows) {
        _selectedRows = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _selectedRows;
}

- (NSMutableDictionary *)validRows
{
    if (!_validRows) {
        _validRows = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _validRows;
}

- (void)setDetailModel:(ProductDetailModel *)detailModel
{
    _detailModel = detailModel;
    self.intoCartModel.productId = kIntToString(detailModel.productId);
    
    [self initialData];
    [self setSkuItemDefault];
    [self updateSubViewsConstraints];
}

- (void)setProductDetailBottomViewType:(ProductDetailBottomViewType)productDetailBottomViewType
{
    _productDetailBottomViewType = productDetailBottomViewType;
    self.intoCartModel.productDetailBottomViewType = productDetailBottomViewType;
}

@end


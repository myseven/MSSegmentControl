//
//  MSSegmentControl.h
//  Reader
//
//  Created by spriteApp on 15/3/5.
//  Copyright (c) 2015年 spriteapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSegmentButton.h"

@class MSSegmentControl;

typedef void(^SelectionBlock)(MSSegmentControl *segmentControl , NSUInteger curIndex, NSInteger preIndex);

@interface MSSegmentControl : UIView

// 选中背景颜色
@property (nonatomic,strong) UIColor *selectedColor;
// 未选中背景颜色
@property (nonatomic,strong) UIColor *color;
// 文字字体
@property (nonatomic,strong) UIFont *textFont;
// 边线颜色
@property (nonatomic,strong) UIColor *borderColor;
// 边线宽度
@property (nonatomic) CGFloat borderWidth;
// 正常状态文字属性
@property (nonatomic,strong) NSDictionary *textAttributes;
// 选中状态文字属性
@property (nonatomic,strong) NSDictionary *selectedTextAttributes;
// 是否添加内部分割线
@property (nonatomic, assign) BOOL isShowInnerSeperateLine;
// 内部空隙
@property (assign, nonatomic) CGFloat innerEdgeInset;
// 内部边角
@property (assign, nonatomic) CGFloat innerCornerRadius;
// 初始化选中位置
@property (nonatomic, assign) NSInteger initIndex;
/**
 *  初始化
 *
 *  @param frame segment大小
 *  @param items item标题
 *  @param block 选中事件回调
 *
 *  @return
 */
- (id)initWithFrame:(CGRect)frame items:(NSArray*)items selectionBlock:(SelectionBlock)block;


- (void)manualChangeSelectedItem:(NSInteger)index;


@end

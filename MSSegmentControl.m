//
//  MSSegmentControl.m
//  Reader
//
//  Created by spriteApp on 15/3/5.
//  Copyright (c) 2015年 spriteapp. All rights reserved.
//

#import "MSSegmentControl.h"


#define segment_corner 3.0

@interface MSSegmentControl()

@property (nonatomic,strong) NSMutableArray *segments;
@property (nonatomic) NSUInteger currentSelected;
@property (nonatomic,strong) NSMutableArray *separators;
@property (nonatomic,copy) SelectionBlock selectionBlock;
@property (nonatomic, strong) NSMutableArray *innerSeperateLines;

@end

@implementation MSSegmentControl

- (id)initWithFrame:(CGRect)frame items:(NSArray*)items selectionBlock:(SelectionBlock)block {
    self = [super initWithFrame:frame];
    if (self) {
        
        _selectionBlock = block;
        self.backgroundColor = [UIColor clearColor];
        self.innerSeperateLines = [NSMutableArray array];
        self.isShowInnerSeperateLine = YES;
        self.innerEdgeInset = 0;
        
        float buttonWidth = frame.size.width / items.count;
        NSInteger i = 0;
        for(NSString *itemText in items){
            
            MSSegmentButton *button =[[MSSegmentButton alloc] initWithFrame:CGRectMake(buttonWidth * i, 0, buttonWidth, frame.size.height) text:itemText textAttributes:nil];
            
            [button addTarget:self action:@selector(segmentSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self.segments addObject:button];
            [self addSubview:button];
            
            // 添加分割线
            if(i != 0){
                
                UIView *separatorView=[[UIView alloc] initWithFrame:CGRectMake(i * buttonWidth, 0, self.borderWidth, frame.size.height)];
                [self addSubview:separatorView];
                [self.separators addObject:separatorView];
                [self.innerSeperateLines addObject:separatorView];
            }
            
            i++;
        }
        
        // 圆角
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = segment_corner;
        
        // 初始选中第一个
        _currentSelected=0;
    }
    return self;
}

#pragma mark - Lazy instantiations
-(NSMutableArray*)segments{
    if(!_segments)_segments=[[NSMutableArray alloc] init];
    return _segments;
}
-(NSMutableArray*)separators{
    if(!_separators)_separators=[[NSMutableArray alloc] init];
    return _separators;
}

- (void)manualChangeSelectedItem:(NSInteger)index{
    UIButton *button = self.segments[index];
    [self segmentSelected:button];
}

- (void)segmentSelected:(id)sender {
    
    if(sender){
        NSUInteger selectedIndex=[self.segments indexOfObject:sender];
        NSInteger preIndex = self.currentSelected;
        self.currentSelected=selectedIndex;
        [self setEnabled:YES forSegmentAtIndex:selectedIndex];
        [self callBackWithCurIndex:selectedIndex preIndex:preIndex];
    }
}

- (void)callBackWithCurIndex:(NSInteger)curIndex preIndex:(NSInteger)preIndex{

    if(self.selectionBlock){
        self.selectionBlock(self, curIndex, preIndex);
    }
}

-(BOOL)isEnabledForSegmentAtIndex:(NSUInteger)index{
    return (index==self.currentSelected);
}

#pragma mark - Setters
-(void)updateSegmentsFormat{
    
    //Setting border color
    if(self.borderColor){
        self.layer.borderWidth=self.borderWidth;
        self.layer.borderColor=self.borderColor.CGColor;
    }else{
        self.layer.borderWidth=0;
    }
    
    //Updating segments color
    for(UIView *separator in self.separators){
        separator.backgroundColor=self.borderColor;
        separator.frame=CGRectMake(separator.frame.origin.x, separator.frame.origin.y,self.borderWidth , separator.frame.size.height);
    }
    
    //Modifying buttons with current State
    for (MSSegmentButton *segment in self.segments){
        
        //Setting format depending on if it's selected or not
        if([self.segments indexOfObject:segment]==self.currentSelected){
            //Selected-one
            if(self.selectedColor)[segment setBackgroundColor:self.selectedColor forUIControlState:UIControlStateNormal];
            if(self.selectedTextAttributes)
                [segment setTextAttributes:self.selectedTextAttributes forUIControlState:UIControlStateNormal];
        }else{
            //Non selected
            if(self.color)[segment setBackgroundColor:self.color forUIControlState:UIControlStateNormal];
            if(self.textAttributes)
                [segment setTextAttributes:self.textAttributes forUIControlState:UIControlStateNormal];
        }
        segment.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
}
-(void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor=selectedColor;
    [self updateSegmentsFormat];
}
-(void)setColor:(UIColor *)color{
    _color=color;
    [self updateSegmentsFormat];
}
-(void)setBorderWidth:(CGFloat)borderWidth{
    _borderWidth=borderWidth;
    [self updateSegmentsFormat];
}

/**
 *	Using this method name of a specified segmend can be changed
 *
 *	@param	title	Title to be applied to the segment
 *	@param	index	Index of the segment that has to be modified
 */

-(void)setTitle:(id)title forSegmentAtIndex:(NSUInteger)index{
    
    //Getting the Segment
    if(index < self.segments.count){
        MSSegmentButton *segment=self.segments[index];
        if([title isKindOfClass:[NSString class]]){
            [segment setButtonText:title];
        }else if ([title isKindOfClass:[NSAttributedString class]]){
            [segment setButtonText:title];
        }
    }
}
-(void)setBorderColor:(UIColor *)borderColor{
    //Setting boerder color to all view
    _borderColor=borderColor;
    [self updateSegmentsFormat];
}
/**
 *	Method for select/unselect a segment
 *
 *	@param	enabled	BOOL if the given segment has to be enabled/disabled ( currently disable option is not enabled )
 *	@param	segment	Segment to be selected/unselected
 */
-(void)setEnabled:(BOOL)enabled forSegmentAtIndex:(NSUInteger)segment{
    if(enabled){
        [self updateSegmentsFormat];
    }
}
-(void)setTextAttributes:(NSDictionary *)textAttributes{
    _textAttributes=textAttributes;
    [self updateSegmentsFormat];
}

-(void)setSelectedTextAttributes:(NSDictionary *)selectedTextAttributes{
    _selectedTextAttributes=selectedTextAttributes;
    [self updateSegmentsFormat];
}

-(void)setIsShowInnerSeperateLine:(BOOL)isShowInnerSeperateLine {
    _isShowInnerSeperateLine = isShowInnerSeperateLine;
    if (!isShowInnerSeperateLine) {
        [self.innerSeperateLines enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            [view removeFromSuperview];
        }];
        [self.innerSeperateLines removeAllObjects];
    }
}

-(void)setInnerEdgeInset:(CGFloat)innerEdgeInset {
    _innerEdgeInset = innerEdgeInset;
    [self.segments enumerateObjectsUsingBlock:^(MSSegmentButton *btn, NSUInteger idx, BOOL *stop) {
        CGRect rect = btn.frame;
        rect.origin.x += innerEdgeInset;
        rect.origin.y += innerEdgeInset;
        rect.size.width -= 2 * innerEdgeInset;
        rect.size.height -= 2 * innerEdgeInset;
        btn.frame = rect;
    }];
}

-(void)setInnerCornerRadius:(CGFloat)innerCornerRadius {
    _innerCornerRadius = innerCornerRadius;
    [self.segments enumerateObjectsUsingBlock:^(MSSegmentButton *btn, NSUInteger idx, BOOL *stop) {
        btn.layer.cornerRadius = innerCornerRadius;
    }];
}

-(void)setInitIndex:(NSInteger)initIndex {
    _initIndex = initIndex;
    self.currentSelected=initIndex;
    [self setEnabled:YES forSegmentAtIndex:initIndex];
}

@end

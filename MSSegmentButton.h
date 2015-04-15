//
//  MSSegmentButton.h
//  Reader
//
//  Created by spriteApp on 15/3/5.
//  Copyright (c) 2015年 spriteapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

@interface MSSegmentButton : UIButton

- (id)initWithFrame:(CGRect)frame text:(NSString*)text textAttributes:(NSDictionary*)attributes;

-(void)setTextAttributes:(NSDictionary*)attributes forUIControlState:(UIControlState)state;
-(void)setBackgroundColor:(UIColor*)color forUIControlState:(UIControlState)state;
-(void)setButtonText:(NSString*)text;
-(void)setRadius:(CGFloat)radius;
-(void)setSeparation:(NSUInteger)separation;
-(void)setIsAwesome:(BOOL)isAwesome;


@end

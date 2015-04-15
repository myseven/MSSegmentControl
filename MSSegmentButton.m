//
//  MSSegmentButton.m
//  Reader
//
//  Created by spriteApp on 15/3/5.
//  Copyright (c) 2015年 spriteapp. All rights reserved.
//

#import "MSSegmentButton.h"

static char buttonTextKey;
static char backgroundColorsKey;
static char textAttributesKey;
static char isAwesomeKey;
static char separationKey;

@implementation MSSegmentButton

- (id)initWithFrame:(CGRect)frame text:(NSString*)text textAttributes:(NSDictionary*)attributes{
    self=[super initWithFrame:frame];
    if(self){
        
        [self setIsAwesome:YES];
        [self setButtonText:text];
        [self setTextAttributes:attributes forUIControlState:UIControlStateNormal];
    }
    return self;
}

-(void)updateButtonFormatForUIControlState:(UIControlState)state{
    
    if([self isAwesome]){
        //Mutable String to set to the button
        NSMutableAttributedString *mutableString=[[NSMutableAttributedString alloc] init];
        
        //Mutable String of text
        NSMutableAttributedString *mutableStringText=[[NSMutableAttributedString alloc] initWithString:@""];
        if([self buttonText])
            [mutableStringText appendAttributedString:[[NSAttributedString alloc] initWithString:[self buttonText]]];
        //Setting color
        UIColor *color = [self backgroundColors][@(state)];
        if(!color)
            color = [self backgroundColors][@(UIControlStateNormal)];
        
        if(color){
            [self setBackgroundColor:color];
        }
        
        //Setting attributes
        NSDictionary *textAttributes=[self textAttributes][@(state)];
        if(!textAttributes)
            textAttributes=[self textAttributes][@(UIControlStateNormal)];
        if(textAttributes){
            //Setting attributes to text
            [mutableStringText setAttributes:textAttributes range:NSMakeRange(0, [[self buttonText] length])];
        }
        
        //Separation
        NSMutableString *separationString=[NSMutableString stringWithFormat:@""];
        if([self separation]){
            int separationInt=[[self separation] intValue];
            for(int i=0;i<separationInt;i++){
                [separationString appendString:@" "];
            }
        }
        [mutableString appendAttributedString:mutableStringText];
        [mutableString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" "]];
        [mutableString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:separationString]];
        
        //Setting to the button
        [self setAttributedTitle:mutableString forState:UIControlStateNormal];
    }
}

#pragma mark -
#pragma mark Touches

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if([self isAwesome])
        [self updateButtonFormatForUIControlState:UIControlStateHighlighted];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    if([self isAwesome])
        [self updateButtonFormatForUIControlState:UIControlStateNormal];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self updateButtonFormatForUIControlState:UIControlStateNormal];
}


#pragma mark - Category properties
-(void)setTextAttributes:(NSDictionary*)attributes forUIControlState:(UIControlState)state{
    NSMutableDictionary *textAttributes=[self textAttributes];
    if(!textAttributes){
        textAttributes=[[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, &textAttributesKey,textAttributes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    //Setting attributes
    if(attributes)
        textAttributes[@(state)]=attributes;
    
    [self updateButtonFormatForUIControlState:UIControlStateNormal];
}

-(void)setRadius:(CGFloat)radius{
    self.layer.cornerRadius=radius;
}

- (NSMutableDictionary*) textAttributes {
    return objc_getAssociatedObject(self, &textAttributesKey);
}

-(void)setBackgroundColor:(UIColor*)color forUIControlState:(UIControlState)state{
    NSMutableDictionary *backgroundColors=[self backgroundColors];
    if(!backgroundColors){
        backgroundColors=[[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, &backgroundColorsKey,backgroundColors, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    //Setting attributes
    if(color)
        backgroundColors[@(state)]=color;
    
    [self updateButtonFormatForUIControlState:UIControlStateNormal];
}
- (NSMutableDictionary*) backgroundColors {
    return objc_getAssociatedObject(self, &backgroundColorsKey);
}

-(void)setButtonText:(NSString*)text{
    objc_setAssociatedObject(self, &buttonTextKey,text, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateButtonFormatForUIControlState:UIControlStateNormal];
}
- (NSString*) buttonText {
    return objc_getAssociatedObject(self, &buttonTextKey);
}

-(void)setSeparation:(NSUInteger)separation{
    objc_setAssociatedObject(self, &separationKey,@(separation), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateButtonFormatForUIControlState:UIControlStateNormal];
}
- (NSNumber*) separation {
    return objc_getAssociatedObject(self, &separationKey);
}

-(void)setIsAwesome:(BOOL)awesome{
    objc_setAssociatedObject(self, &isAwesomeKey,@(awesome), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateButtonFormatForUIControlState:UIControlStateNormal];
}
- (BOOL) isAwesome {
    return objc_getAssociatedObject(self, &isAwesomeKey)?YES:NO;
}
@end

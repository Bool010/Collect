//
//  XWIndexView.m
//  Check
//
//  Created by 付国良 on 2017/3/29.
//  Copyright © 2017年 Cocoa. All rights reserved.
//

#import "XWIndexView.h"

@interface XWIndexView ()

@property (nonatomic, copy) NSArray <UILabel *> *labelArr;
@property (nonatomic, assign) NSInteger lastTouchIndex;

@end


@implementation XWIndexView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    for (UILabel *label in self.labelArr) {
        label.font = font;
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    for (UILabel *label in self.labelArr) {
        label.textColor = textColor;
    }
}

- (void)setIndexArray:(NSArray<NSString *> *)indexArray
{
    if (!_indexArray) {
        NSMutableArray *labelArr = @[].mutableCopy;
        CGFloat height = self.frame.size.height / indexArray.count;
        for (NSInteger i = 0; i < indexArray.count; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                       i * height,
                                                                       self.frame.size.width,
                                                                       height)];
            label.textColor = [UIColor lightGrayColor];
            label.font = [UIFont systemFontOfSize:15.0];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = indexArray[i];
            [self addSubview:label];
            [labelArr addObject:label];
        }
        self.labelArr = labelArr;
    }
    _indexArray = indexArray;
}

- (NSInteger)calculateTouchIndexWithEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self];
    NSInteger index = ((NSInteger) floorf(point.y) / (self.frame.size.height/self.indexArray.count));
    if (index < 0 || index > self.indexArray.count - 1) {
        if (index < 0) {
            return 0;
        } else {
            return self.indexArray.count - 1;
        }
    }
    return index;
}


#pragma mark - <<<<<< touches >>>>>> -
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    NSInteger touchIndex = [self calculateTouchIndexWithEvent:event];
    if (self.touchBegin) {
        self.touchBegin(touchIndex);
    }
    self.lastTouchIndex = touchIndex;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    NSInteger touchIndex = [self calculateTouchIndexWithEvent:event];
    
    if (self.touchMove) {
        self.touchMove(touchIndex);
    }
    if (touchIndex != self.lastTouchIndex) {
        if (self.touchMoveIndexChange) {
            self.touchMoveIndexChange(touchIndex);
        }
        self.lastTouchIndex = touchIndex;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (self.touchEnd) {
        self.touchEnd();
    }
}

@end

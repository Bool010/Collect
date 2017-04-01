//
//  UIButton+WNCategory.m
//  wannarTwo
//
//  Created by 付国良 on 16/5/5.
//  Copyright © 2016年 玩哪儿旅行. All rights reserved.
//

#import "UIButton+XW.h"
#import <objc/runtime.h>

static const void *associatedKey = "associatedKey";

@implementation UIButton (XW)

/** 为Button扩充一个点击的Block属性 */
- (void)setClick:(clickBlock)click
{
    objc_setAssociatedObject(self, associatedKey, click, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self removeTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    if (click) {
        [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (clickBlock)click
{
    return objc_getAssociatedObject(self, associatedKey);
}

- (void)buttonClick:(UIButton *)sender
{
    if (self.click) {
        self.click(sender);
    }
}

@end

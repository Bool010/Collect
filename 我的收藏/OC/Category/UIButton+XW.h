//
//  UIButton+WNCategory.h
//  wannarTwo
//
//  Created by 付国良 on 16/5/5.
//  Copyright © 2016年 玩哪儿旅行. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^clickBlock)(UIButton *btn);


@interface UIButton (XW)

@property (nonatomic,copy) clickBlock click;

@end

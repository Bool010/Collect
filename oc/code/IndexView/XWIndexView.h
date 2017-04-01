//
//  XWIndexView.h
//  Check
//
//  Created by 付国良 on 2017/3/29.
//  Copyright © 2017年 Cocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWIndexView : UIView

// The title of the index array
@property (nonatomic, copy) NSArray <NSString *> *indexArray;

// Touch begin
@property (nonatomic, copy) void(^touchBegin)(NSInteger index);

// Finger movement
@property (nonatomic, copy) void(^touchMove)(NSInteger index);

// Finger movement and index change
@property (nonatomic, copy) void(^touchMoveIndexChange)(NSInteger index);

// Touch end
@property (nonatomic, copy) void(^touchEnd)(void);


@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;

@end

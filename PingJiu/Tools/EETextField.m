//
//  EETextField.m
//  QuanQiuBang
//
//  Created by 橙晓侯 on 16/1/27.
//  Copyright © 2016年 小马网络. All rights reserved.
//

#import "EETextField.h"

@implementation EETextField

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // 边框
    if (_borderWidth > 0) {
        
        self.layer.borderWidth = _borderWidth;
        self.layer.borderColor = _borderColor.CGColor;
        
    }
    
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    
    _cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}

- (void)setBorderColor:(UIColor *)borderColor {
    
    _borderColor = borderColor;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    
    _borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = borderWidth;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    
    if (_leftViewFrame.origin.x != 0)
    {
        return _leftViewFrame;
    }
    return [super leftViewRectForBounds:bounds];
}

- (UILabel *)placeholderLabel
{
    return [self valueForKey:@"_placeholderLabel"];
}

- (void)setLeftSpace:(CGFloat)leftSpace
{
    if (leftSpace > 0) {
        
        _leftSpace = leftSpace;
        CGRect frame = [self frame];
        frame.size.width = leftSpace;
        UIView *leftview = [[UIView alloc] initWithFrame:frame];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView = leftview;
    }
}

/** 防止UITextBorderStyleNone编辑文字时偏移 */
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 1 , 0 );
}
@end

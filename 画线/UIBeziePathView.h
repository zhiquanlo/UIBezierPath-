//
//  UIBeziePathView.h
//  画线
//
//  Created by 李志权 on 16/7/20.
//  Copyright © 2016年 李志权. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBeziePathView : UIView
{
    CAShapeLayer *_trackLayer;
    UIBezierPath *_trackPath;
    CAShapeLayer *_progressLayer;
    UIBezierPath *_progressPath;
}
@property (nonatomic, strong) UIColor *trackColor;
@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic) float progress;//0~1之间的数
@property (nonatomic) float progressWidth;

- (void)setProgress:(float)progress animated:(BOOL)animated;
@end

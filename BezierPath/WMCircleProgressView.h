//
//  WMCircleProgressView.h
//  BezierPath
//
//  Created by Mac on 15-6-5.
//  Copyright (c) 2015年 wmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMCircleProgressView : UIView

@property (nonatomic, strong) UIColor *trackColor;
@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic) float progress;//0~1之间的数
@property (nonatomic) float progressWidth;
/**
 *  设置进度
 *
 *  @param progress 0——1的浮点型
 *  @param animated 是否增加动画
 */
- (void)setProgress:(float)progress animated:(BOOL)animated;
/**
 *  设置文字的大熊啊
 *
 *  @param font 字体类型
 */
- (void)setWordFont:(UIFont*)font;
@end

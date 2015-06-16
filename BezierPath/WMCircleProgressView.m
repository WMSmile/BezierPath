//
//  WMCircleProgressView.m
//  BezierPath
//
//  Created by Mac on 15-6-5.
//  Copyright (c) 2015年 wmeng. All rights reserved.
//

#import "WMCircleProgressView.h"
#define WMProgressWidth 5
#define AnimationDuration 3.0f
@interface WMCircleProgressView()
{
    CAShapeLayer *_trackLayer;
    UIBezierPath *_trackPath;
    CAShapeLayer *_progressLayer;
    UIBezierPath *_progressPath;
    UILabel      *_percentageLB;
}

@end

@implementation WMCircleProgressView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //显示的百分比
        
        _percentageLB = [UILabel new];
        _percentageLB.frame = self.bounds;
        _percentageLB.textAlignment = NSTextAlignmentCenter;
        _percentageLB.text = @"0%";
        [self addSubview:_percentageLB];
        //底部的灰色
        _trackLayer = [CAShapeLayer new];
        [self.layer addSublayer:_trackLayer];
        _trackLayer.fillColor = nil;
        _trackLayer.frame = self.bounds;
    
        //进度条的颜色
        _progressLayer = [CAShapeLayer new];
        [self.layer addSublayer:_progressLayer];
        _progressLayer.fillColor = nil;
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.frame = self.bounds;
        
        
        //默认5
        self.progressWidth = WMProgressWidth;
        
      
        
        
        
    }
    return self;
}

- (void)setTrack
{
    _trackPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.height/2.0f, self.frame.size.width/2.0f)
                                                radius:(self.bounds.size.width - _progressWidth)/ 2
                                            startAngle:0
                                              endAngle:M_PI * 2
                                             clockwise:YES];;
    _trackLayer.path = _trackPath.CGPath;
}

- (void)setProgress
{
    _progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.height/2.0f, self.frame.size.width/2.0f)
                                                   radius:(self.bounds.size.width - _progressWidth)/ 2
                                               startAngle:- M_PI_2
                                                 endAngle:(M_PI * 2) * _progress - M_PI_2 clockwise:YES];
    _progressLayer.path = _progressPath.CGPath;
}


- (void)setProgressWidth:(float)progressWidth
{
    if (_progressWidth != progressWidth) {
        _progressWidth = progressWidth;
        _trackLayer.lineWidth = _progressWidth;
        _progressLayer.lineWidth = _progressWidth;
        
        [self setTrack];
        [self setProgress];
    }
    
}

- (void)setTrackColor:(UIColor *)trackColor
{
    if (_trackColor != trackColor) {
        _trackLayer.strokeColor = trackColor.CGColor;

    }
}

- (void)setProgressColor:(UIColor *)progressColor
{
    if (_progressColor != progressColor) {
        _progressLayer.strokeColor = progressColor.CGColor;

    }
}

- (void)setProgress:(float)progress
{
    if (_progress != progress) {
        _progress = progress;
        [self setProgress];
    }
   
}

- (void)setProgress:(float)progress animated:(BOOL)animated
{
    if (animated) {
        
        self.progress = progress;
        [self percentLBAnimation];//添加数字更换动画
        [self addAnimation];//添加进度条动画
     
        
    }
    else
    {
        self.progress = progress;
        _percentageLB.text = [NSString stringWithFormat:@"%f%@",self.progress*100,@"%"];

    }
}
/**
 *  进度条动画
 */
- (void)addAnimation
{
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = AnimationDuration;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:self.progress];
    [_progressLayer addAnimation:pathAnimation forKey:nil];
}
/**
 *  数字更换动画
 */
- (void)percentLBAnimation
{
   __block int timeout = 0;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),(AnimationDuration/(self.progress*100))*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout>=self.progress*100){
            dispatch_source_cancel(_timer);//结束关闭
            dispatch_async(dispatch_get_main_queue(), ^{
                _percentageLB.text = [NSString stringWithFormat:@"%d%@",timeout,@"%"];

            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                _percentageLB.text = [NSString stringWithFormat:@"%d%@",timeout,@"%"];
                
            });
            timeout ++;
            
        }
    });
    dispatch_resume(_timer);
}
/**
 *  设置字体
*/
- (void)setWordFont:(UIFont *)font
{
    if (_percentageLB.font != font) {
        _percentageLB.font = font;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  ViewController.m
//  BezierPath
//
//  Created by Mac on 15-6-4.
//  Copyright (c) 2015年 wmeng. All rights reserved.
//

#import "ViewController.h"
#import "WMCircleProgressView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//画圆
//    CAShapeLayer *layer = [CAShapeLayer new];
//    [self.view.layer addSublayer:layer];
//    layer.fillColor = nil;
//    layer.frame = self.view.bounds;
//    
//    layer.path = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:self.view.frame.size.width/2-100 startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath;
//    
//    layer.strokeColor = [UIColor redColor].CGColor;
//    layer.lineWidth = 10;
    
    //显示进度条的按钮
    UIButton *showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    showBtn.frame = CGRectMake(20, CGRectGetHeight(self.view.frame)-40-100, CGRectGetWidth(self.view.frame)-40, 40);
    [showBtn setTitle:@"出现进度条" forState:UIControlStateNormal];
    showBtn.backgroundColor = [UIColor lightGrayColor];
    [showBtn addTarget:self action:@selector(showBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:showBtn];
    
 
    
    
    
    
}
/**
 *  显示进度条
 *
 *  @param sender 按钮自身
 */
- (void)showBtnClick:(UIButton *)sender
{
    //自定义的进度条
    WMCircleProgressView *progress = [[WMCircleProgressView alloc] initWithFrame:CGRectMake(20, 20, 200, 200)];
    //    progress.center = self.view.center;
    [self.view addSubview:progress];
    progress.trackColor = [UIColor blackColor];
    progress.progressColor = [UIColor orangeColor];
    progress.progressWidth = 10;
    [progress setProgress:0.9 animated:YES];
    [progress setWordFont:[UIFont systemFontOfSize:30]];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

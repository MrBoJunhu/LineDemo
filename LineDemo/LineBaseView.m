//
//  LineBaseView.m
//  LineDemo
//
//  Created by bill on 16/10/31.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "LineBaseView.h"

@interface LineBaseView ()<CAAnimationDelegate>

@end


@implementation LineBaseView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // 画坐标轴
    
    // 设置上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 设置线宽
    CGContextSetLineWidth(context, 1.0);
    
    // 设置画笔颜色
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    
    // 开始坐标
    CGContextMoveToPoint(context, _bounceX, _bounceY);
    
    
    // 绘制Y轴
    CGContextAddLineToPoint(context, _bounceX, rect.size.height - _bounceY);

    // 绘制X轴
    CGContextAddLineToPoint(context, rect.size.width - _bounceX, rect.size.height - _bounceY);
    
    // 开始绘图
    CGContextStrokePath(context);
    
    // X轴
    [self createLabelX];
    
    // Y轴
    [self createLabelY];
    
    // 渐变色
    [self drawGradientBackgroundView];
    
    // 绘制虚线
    [self setLineDash];
    
    // 绘制折线
//    [self drawLine];

}


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
       
        self.backgroundColor = [UIColor whiteColor];
   
    }
    
    return self;
    
}


#pragma mark - 创建X轴数据
- (void)createLabelX {
    
    CGFloat month = 12;
    
    for (NSInteger i = 0 ; i < month; i ++) {
        
        UILabel *monthLB = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 2 * _bounceX) / month * i + _bounceX, self.frame.size.height - _bounceY + 2, (self.frame.size.width - 2 * _bounceX) / month - 5, _bounceY * 1.5)];
        
        monthLB.tag = 1000 + i;
        
        monthLB.textColor = [UIColor blackColor];
        
        monthLB.backgroundColor = [UIColor redColor];
        
        monthLB.text = [NSString stringWithFormat:@"%ld\n月", i + 1];
        
        monthLB.numberOfLines = 2;
        
        monthLB.textAlignment = NSTextAlignmentCenter;
        
        monthLB.lineBreakMode = NSLineBreakByWordWrapping;
        
        monthLB.font = [UIFont systemFontOfSize:9.f];
        
//        monthLB.transform = CGAffineTransformMakeRotation(M_PI * 0.3);
        
        [self addSubview:monthLB];
        
    }
    
}

#pragma mark - 创建Y轴数据
- (void)createLabelY {
    
    CGFloat Ydivision = 6;
    
    for (NSInteger i = 0 ; i < Ydivision; i ++) {

        UILabel *yLB = [[UILabel alloc] initWithFrame:CGRectMake( -_bounceY * 1.5, (self.frame.size.height - 2 * _bounceY) / Ydivision * i + _bounceY, _bounceY * 1.5, _bounceY / 2.0)];
        
        yLB.tag = 2000 + i;
        
        yLB.textColor = [UIColor blackColor];
        
        yLB.backgroundColor = [UIColor greenColor];
        
        yLB.text = [NSString stringWithFormat:@"%.1f", (Ydivision - i) * 100];
        
        yLB.font = [UIFont systemFontOfSize:9.0f];
        
        [self addSubview:yLB];
        
    }
    
}


#pragma mark - 创建颜色渐变背景
- (void)drawGradientBackgroundView {

    // 渐变背景视图不包含坐标轴
    self.gradientBackV = [[UIView alloc] initWithFrame:CGRectMake(_bounceX, 0, self.bounds.size.width, self.bounds.size.height - _bounceY)];
    
    // 添加渐变色视图
    [self addSubview:self.gradientBackV];
   
    // 创建并设置渐变图层
    self.gradientLayer = [CAGradientLayer layer];
    
    self.gradientLayer.frame = self.gradientBackV.bounds;
   
    //设置渐变区域的起始和终止位置（范围为0-1），即渐变路径
    self.gradientLayer.startPoint = CGPointMake(0.0f, 0.0f);
    
    self.gradientLayer.endPoint = CGPointMake(1.0f, 0.0f);
    
    //设置颜色的渐变过程
    self.colorArray = [NSMutableArray arrayWithArray:@[(__bridge id)[UIColor colorWithRed:253 / 255.0 green:164 / 255.0 blue:8 / 255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:251 / 255.0 green:37 / 255.0 blue:45 / 255.0 alpha:1.0].CGColor]];
    
    self.gradientLayer.colors = self.colorArray;
    
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [self.gradientBackV.layer addSublayer:self.gradientLayer];
    
    
}

#pragma mark - 画横轴虚线
- (void)setLineDash {
    
    for (NSInteger i = 0; i < 6; i ++) {
        
        CAShapeLayer *dashLayer = [CAShapeLayer layer];
        
        dashLayer.strokeColor = [UIColor lightTextColor].CGColor;
        
        dashLayer.fillColor = [UIColor clearColor].CGColor;
        
        // 虚线设置样式
        dashLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInteger:1], nil];
        
        // 默认设置路径宽度为0，使其在起始状态下不显示
        dashLayer.lineWidth = 1.0;

        //获取x轴数据label的位置根据其位置画横虚线
        UILabel * label1 = (UILabel*)[self viewWithTag:2000 + i];

        UIBezierPath *path = [[UIBezierPath alloc] init];
        
        path.lineWidth = 0.5;
        
        UIColor *color = [UIColor blueColor];
        
        [color set];
        
        [path moveToPoint:CGPointMake(0, label1.center.y)];
        
        [path addLineToPoint:CGPointMake(self.frame.size.width, label1.center.y)];
        
        CGFloat dash = {10, 10};
        
        [path setLineDash:&dash count:2 phase:10];
        
        [path stroke];
        
        dashLayer.path = path.CGPath;
        
        [self.gradientBackV.layer addSublayer:dashLayer];
        
    }
    
}

#pragma mark - 绘制折线
- (void)drawLine {
    
    //根据横坐标上面的label 获取直线关键点的x 值
    UILabel *label = (UILabel *)[self viewWithTag:1000];
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    path.lineWidth = 1.0;
    
    self.path1 = path;
    
    UIColor *color = [UIColor greenColor];
    
    [color set];
    
    [path moveToPoint:CGPointMake(label.frame.origin.x, ( 600 -arc4random() % 600 ) / 600.0 * ( self.frame.size.height - _bounceY * 2))];
    
    // 创建折线点标记
    for (NSInteger i = 0 ; i < 12; i ++) {
        
        UILabel *lb = (UILabel *)[self viewWithTag:1000 + i];
        
        CGFloat arc = arc4random() % 600;
        
        [path addLineToPoint:CGPointMake(lb.frame.origin.x - _bounceX,  (600 -arc) /600.0 * (self.frame.size.height - _bounceY*2 ) )];
        
        
        UILabel * flaglabel = [[UILabel alloc]initWithFrame:CGRectMake(lb.frame.origin.x , (600 -arc) /600.0 * (self.frame.size.height - _bounceY*2 )+ _bounceY  , 30, 15)];
        
        flaglabel.backgroundColor = [UIColor greenColor];
        
        flaglabel.tag = 3000 + i;
        
        flaglabel.text = [NSString stringWithFormat:@"%.1f", arc];
        
        flaglabel.font = [UIFont systemFontOfSize:8.0f];
        
        [self addSubview:flaglabel];
    }
    
    [path stroke]; //画线
    
    self.lineChartLayer = [CAShapeLayer layer];
    
    self.lineChartLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    self.lineChartLayer.path = path.CGPath;

    self.lineChartLayer.strokeColor = [UIColor redColor].CGColor;

    self.lineChartLayer.fillColor = [UIColor clearColor].CGColor;

    // 默认设置路径宽度为0，使其在起始状态下不显示
    self.lineChartLayer.lineWidth = 0;

    self.lineChartLayer.lineCap = kCALineCapRound;

    self.lineChartLayer.lineJoin = kCALineJoinRound;

    //直接添加导视图上
//    [self.gradientBackV.layer addSublayer:self.lineChartLayer];

    
//    //添加到渐变图层
    self.gradientBackV.layer.mask = self.lineChartLayer;
    
}

/*
#pragma mark - 画线动画
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    NSInteger touchFingerCount = touch.tapCount;
    
    if (touchFingerCount % 2 == 0) {
        
        // 点击一次删除折线和转折点数据. flagLabel
        [self.lineChartLayer removeFromSuperlayer];
        
        for (NSInteger i = 0; i < 12; i ++) {
            
            UILabel *label = (UILabel *)[self viewWithTag:3000 + i];
            
            [label removeFromSuperview];
            
        }
        
    }else{
        
        [self drawLine];
        
        self.lineChartLayer.lineWidth = 1;
        
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        
        pathAnimation.duration = 3.0;
        
        pathAnimation.repeatCount = 1;
        
        pathAnimation.removedOnCompletion = YES;
        
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        
        // 设置动画代理,动画结束的时候添加一个标签,显示折线终点的信息
        pathAnimation.delegate = self;
        
        [self.lineChartLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
        
//        [self setNeedsDisplay];
        
    }
    
    
    
}

*/
 
 
@end

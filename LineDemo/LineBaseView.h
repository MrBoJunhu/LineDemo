//
//  LineBaseView.h
//  LineDemo
//
//  Created by bill on 16/10/31.
//  Copyright © 2016年 bill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineBaseView : UIView

@property (nonatomic, assign) CGFloat bounceX;

@property (nonatomic, assign) CGFloat bounceY;


// 渐变色
@property (nonatomic, strong) UIView *gradientBackV;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@property (nonatomic, strong) NSMutableArray *colorArray;


// 折线图
@property (nonatomic, strong) CAShapeLayer *lineChartLayer;

@property (nonatomic, strong) UIBezierPath *path1;

@end

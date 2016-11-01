//
//  ViewController.m
//  LineDemo
//
//  Created by bill on 16/10/31.
//  Copyright © 2016年 bill. All rights reserved.
//

#import "ViewController.h"

#import "LineBaseView.h"

@interface ViewController (){
    
    LineBaseView *baseView;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createLineView];
    
}

- (void)createLineView {
    
    baseView = [[LineBaseView alloc] initWithFrame:CGRectMake(30, 200, self.view.bounds.size.width - 60, 200)];
    
    baseView.bounceX = 0;
    
    baseView.bounceY = 20;
    
    [self.view addSubview:baseView];
    
}

@end

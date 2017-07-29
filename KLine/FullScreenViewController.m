//
//  FullScreenViewController.m
//  KLine
//
//  Created by 陈蕃坊 on 2017/7/29.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import "FullScreenViewController.h"

@interface FullScreenViewController ()

@end

@implementation FullScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor greenColor];
    label.text = @"4444";
    label.frame = CGRectMake(0, 0, 50, 50);
    [self.view addSubview:label];
    
}


- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft;
}



@end

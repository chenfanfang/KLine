//
//  ViewController.m
//  KLine
//
//  Created by chenfanfang on 2017/7/24.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import "HomeViewController.h"

//controller
#import "FullScreenViewController.h"

//tools
#import "HttpsManager.h"

//view
#import "ChartsMainView.h"

@interface HomeViewController ()

@property (nonatomic, weak) ChartsMainView *chartsMainView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [HttpsManager requestWithDataType:DataType_TimeLine success:^(id responseObj) {
        NSLog(@"%@",responseObj);
    } error:nil];
}


//=================================================================
//                           懒加载
//=================================================================
#pragma mark - 懒加载
- (ChartsMainView *)chartsMainView {
    if (_chartsMainView == nil) {
        ChartsMainView *chartsMainView = [[ChartsMainView alloc] init];
        [self.view addSubview:chartsMainView];
        self.chartsMainView = chartsMainView;
        
    }
    
    return _chartsMainView;
}





//=================================================================
//                          横屏的处理
//=================================================================
#pragma mark - 横屏的处理
- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft;
}




@end

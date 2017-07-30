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

//model
#import "TimeLineTotalModel.h"

@interface HomeViewController ()<KLineMainViewDataSource>

//k线图的主图
@property (nonatomic, weak) ChartsMainView *chartsMainView;

//分时图的数据模型
@property (nonatomic, strong) TimeLineTotalModel *timeLineTotalModel;

/** 股票信息 */
@property (nonatomic, strong) NSDictionary *stockMessageData;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self chartsMainView];
    
    //获取股票基本信息数据
    [HttpsManager requestWithDataType:DataType_StockMessage success:^(id responseObj) {
        
        self.stockMessageData = responseObj;
    } error:nil];
    
    //获取分时图数据
    [HttpsManager requestWithDataType:DataType_TimeLine success:^(id responseObj) {
    
        //数据转模型处理
        self.timeLineTotalModel  = [TimeLineTotalModel modelWithDict:responseObj];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.chartsMainView reloadData];
        });
        
        
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
        _chartsMainView = chartsMainView;
        [chartsMainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        _chartsMainView.dataSource = self;
        
    }
    
    return _chartsMainView;
}


//=================================================================
//                        KLineMainViewDataSource
//=================================================================
#pragma mark - KLineMainViewDataSource

- (NSDictionary *)stockMessageInKLineMainView:(ChartsMainView *)klineMainView {
    return self.stockMessageData;
}

- (ChartsType)chartsTypeInKLineMainView:(ChartsMainView *)klineMainView {
    return ChartsType_TimeLine;
}

- (id)dataInKLineMainView:(ChartsMainView *)klineMainView {
    return self.timeLineTotalModel;
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

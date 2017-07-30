//
//  KLineMainView.h
//  KLine
//
//  Created by 陈蕃坊 on 2017/7/29.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChartsMainView;



@protocol KLineMainViewDataSource <NSObject>

@required

//股票相关的信息(股票代码、股票名称、今开、昨开....)
- (id)stockMessageInKLineMainView:(ChartsMainView *)klineMainView;

//k线图的类型(分时图、日k、周k....)
- (ChartsType)chartsTypeInKLineMainView:(ChartsMainView *)klineMainView;

//股票实时数据(价格、成交量..用于绘制折线图、成交量图)
- (id)dataInKLineMainView:(ChartsMainView *)klineMainView;



@end

@interface ChartsMainView : UIView

/** 数据源 */
@property (nonatomic, weak) id<KLineMainViewDataSource> dataSource;

- (void)reloadData;

@end

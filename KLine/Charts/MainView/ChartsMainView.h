//
//  KLineMainView.h
//  KLine
//
//  Created by 陈蕃坊 on 2017/7/29.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChartsMainView;

typedef NS_ENUM(NSInteger, ChartsType) {
    //分时图
    ChartsType_TimeLine = 0,
    //日K
    ChartsType_DayKLine,
    //周K
    ChartsType_WeekKLine,
    //月K
    ChartsType_MonthKLine
};

@protocol KLineMainViewDataSource <NSObject>

- (ChartsType)chartsTypeInKLineMainView:(ChartsMainView *)klineMainView;

- (NSArray *)dataArrayInKLineMainView:(ChartsMainView *)klineMainView;

@end

@interface ChartsMainView : UIView

- (void)reloadData;

@end

//
//  Const.h
//  KLine
//
//  Created by 陈蕃坊 on 2017/7/29.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import <Foundation/Foundation.h>

//=================================================================
//                           枚举
//=================================================================
#pragma mark - 枚举

//图表类型
typedef NS_ENUM(NSInteger, KLine_Enum_ChartsType) {
    //分时图
    KLine_Enum_ChartsType_TimeLine = 0,
    //日K
    KLine_Enum_ChartsType_DayKLine,
    //周K
    KLine_Enum_ChartsType_WeekKLine,
    //月K
    KLine_Enum_ChartsType_MonthKLine
};


//股票的涨跌状态
typedef NS_ENUM(NSInteger, KLine_Enum_StockHighsAndLows) {
    //跌
    KLine_Enum_StockHighsAndLows_Lows = 0,
    //涨
    KLine_Enum_StockHighsAndLows_Hights,
    //平
    KLine_Enum_StockHighsAndLows_Flat,
};

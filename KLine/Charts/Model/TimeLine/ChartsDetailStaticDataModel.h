//
//  ChartsDetailModel.h
//  KLine
//
//  Created by chenfanfang on 2017/8/1.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import <Foundation/Foundation.h>

// 显示详情的静态数据模型  （显示在左右两边的数值）
@interface ChartsDetailStaticDataModel : NSObject

//====================
//     折线图所需数据
//====================

/** 折线图所在位置 */
@property (nonatomic, assign) CGRect chartRect;

/** 折线图垂直方向的区间数 */
@property (nonatomic, assign) NSInteger chartVerticalSections;

/** 折线图垂直方向每个区间的高度 */
@property (nonatomic, assign) CGFloat chartVerticalPerSectionHeight;

/** 昨收价 */
@property (nonatomic, assign) CGFloat prePrice;

/** 最低价 */
@property (nonatomic, assign) CGFloat minPrice;

/** 垂直方向，每个像素代表的价钱 */
@property (nonatomic, assign) CGFloat verticalPerPxPrice;

/** 最低涨跌幅 */
@property (nonatomic, assign) CGFloat minUpAndDown;

/** 垂直方法，每个像素代表的涨跌幅 */
@property (nonatomic, assign) CGFloat verticalPerPxUpAndDown;


//=================
//     成交量
//=================

/** 成交量图所在位置 */
@property (nonatomic, assign) CGRect volumeRect;

/** 最多成交量 */
@property (nonatomic, assign) NSInteger maxVolume;

/** 成交量图垂直方向的区间数 */
@property (nonatomic, assign) NSInteger volumeVerticalSections;

/** 成交量图垂直方向每个区间的高度 */
@property (nonatomic, assign) CGFloat volumeVerticalPerSectionHeight;

/** 垂直方向，每个像素代表的成交量 */
@property (nonatomic, assign) CGFloat verticalPerPxVolume;


@end

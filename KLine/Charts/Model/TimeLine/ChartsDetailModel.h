//
//  ChartsDetailModel.h
//  KLine
//
//  Created by chenfanfang on 2017/8/1.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import <Foundation/Foundation.h>

// 显示详情的数据模型
@interface ChartsDetailModel : NSObject

//=================
//     折线图
//=================

/** 折线图所在位置 */
@property (nonatomic, assign) CGRect chartRect;

/** 折线图垂直方向的区间数 */
@property (nonatomic, assign) NSInteger chartSectionsCount;

/** 昨收价 */
@property (nonatomic, assign) CGFloat prePrice;

/** 最低价 */
@property (nonatomic, assign) CGFloat minPrice;

/** 垂直方向，每个像素代表的价钱 */
@property (nonatomic, assign) CGFloat perPxPrice;


//=================
//     成交量
//=================


@end

//
//  TimeLineModel.h
//  KLine
//
//  Created by 陈蕃坊 on 2017/7/29.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import <Foundation/Foundation.h>


//分时图数据模型
@interface TimeLineModel : NSObject

/** 时间 */
@property (nonatomic, copy) NSString *time;

/** 价钱 */
@property (nonatomic, assign) CGFloat price;

/** 均价(在转模型的时候计算出来的) */
@property (nonatomic, assign) CGFloat averagePrice;

/** 成交数 */
@property (nonatomic, assign) NSInteger amount;

/** 成交金额 */
@property (nonatomic, assign) NSInteger totalMoney;


//============================================
//   下面两个属性是在长按显示详细信息的时候计算出来的
//============================================
/** 涨跌幅 */
@property (nonatomic, copy) NSString *upAndDownRate;

/** 涨跌额 */
@property (nonatomic, assign) CGFloat upAndDown;

+ (instancetype)modelWithDataArr:(NSArray *)dataArr;

@end

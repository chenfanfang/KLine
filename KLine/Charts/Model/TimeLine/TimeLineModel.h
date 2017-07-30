//
//  TimeLineModel.h
//  KLine
//
//  Created by 陈蕃坊 on 2017/7/29.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeLineModel : NSObject

/** 时间 */
@property (nonatomic, copy) NSString *time;

/** 价钱 */
@property (nonatomic, assign) CGFloat price;

/** 均价 */
@property (nonatomic, assign) CGFloat averagePrice;

/** 成交数 */
@property (nonatomic, assign) NSInteger amount;

/** 成交金额 */
@property (nonatomic, assign) NSInteger totalMoney;


+ (instancetype)modelWithDataArr:(NSArray *)dataArr;

@end

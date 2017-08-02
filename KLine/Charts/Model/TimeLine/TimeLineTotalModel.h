//
//  TimeLineTotalModel.h
//  KLine
//
//  Created by 陈蕃坊 on 2017/7/29.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import <Foundation/Foundation.h>

//model
#import "TimeLineModel.h"

//分时图数据总模型
@interface TimeLineTotalModel : NSObject

/** 昨收 */
@property (nonatomic, assign) CGFloat preClosePrice;

/** 日期 */
@property (nonatomic, copy) NSString *date;

/** 数据数组 */
@property (nonatomic, strong) NSArray<TimeLineModel *> *dataArr;


+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end

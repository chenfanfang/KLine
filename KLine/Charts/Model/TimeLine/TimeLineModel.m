//
//  TimeLineModel.m
//  KLine
//
//  Created by 陈蕃坊 on 2017/7/29.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import "TimeLineModel.h"

@implementation TimeLineModel

+ (instancetype)modelWithDataArr:(NSArray *)dataArr {
    TimeLineModel *model = [TimeLineModel new];
    NSMutableString *timeStrM = [NSMutableString stringWithFormat:@"%@",dataArr[0]];
    [timeStrM insertString:@":" atIndex:2];
    
    model.time = timeStrM.copy;
    model.price = [dataArr[1] floatValue];
    model.amount = [dataArr[2] integerValue];
    model.totalMoney = [dataArr[3] integerValue];
    model.averagePrice = model.totalMoney * 1.0 / model.amount;
    
    return model;
}

@end

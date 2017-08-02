//
//  TimeLineTotalModel.m
//  KLine
//
//  Created by 陈蕃坊 on 2017/7/29.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import "TimeLineTotalModel.h"

@implementation TimeLineTotalModel

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    TimeLineTotalModel *totalModel = [TimeLineTotalModel new];
    totalModel.preClosePrice = [dict[@"preClosePrice"] floatValue];
    totalModel.date = dict[@"date"];
    NSArray *dataArr = dict[@"data"];
    NSMutableArray *arrM = [NSMutableArray array];
    NSInteger sumPrice = 0;
    NSInteger sumAmount = 0;
    
    for (int i = 0; i < dataArr.count; i++) {
        NSString *dataStr = dataArr[i];
        NSArray *itemArr = [dataStr componentsSeparatedByString:@" "];
        TimeLineModel *model = [TimeLineModel modelWithDataArr:itemArr];
        
        //算均价（用户绘制黄色均线）
        sumPrice += model.price * model.amount;
        sumAmount += model.amount;
        model.averagePrice = sumPrice * 1.0 / sumAmount;
        
        [arrM addObject:model];
    }
    totalModel.dataArr = arrM;
    
    return totalModel;
}

@end

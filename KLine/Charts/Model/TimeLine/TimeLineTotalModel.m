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
    NSArray *dataArr = dict[@"data"];
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSString *dataStr in dataArr) {
        NSArray *itemArr = [dataStr componentsSeparatedByString:@" "];
        TimeLineModel *model = [TimeLineModel modelWithDataArr:itemArr];
        [arrM addObject:model];
    }
    totalModel.dataArr = arrM;
    
    return totalModel;
}

@end

//
//  HttpsManager.h
//  KLine
//
//  Created by chenfanfang on 2017/7/25.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DataType) {
    //分时数据
    DataType_TimeLine = 0,
    //股票信息
    DataType_StockMessage,
    //日K
    DataType_DayKLine
};


//加载数据的工具类(模拟网络请求)
@interface HttpsManager : NSObject

+ (void)requestWithDataType:(DataType)dataType success:(void(^)(id responseObj))successBlock error:(void(^)(NSError *error))errorBlock;

@end

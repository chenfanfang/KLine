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
    //日K
    DataType_DayKLine
};

@interface HttpsManager : NSObject

+ (void)requestWithDataType:(DataType)dataType success:(void(^)(id responseObj))successBlock error:(void(^)(NSError *error))errorBlock;

@end

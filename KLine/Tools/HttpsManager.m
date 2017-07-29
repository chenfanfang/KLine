//
//  HttpsManager.m
//  KLine
//
//  Created by chenfanfang on 2017/7/25.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import "HttpsManager.h"

@implementation HttpsManager

+ (void)requestWithDataType:(DataType)dataType success:(void (^)(id responseObj))successBlock error:(void (^)(NSError *))errorBlock {
    
    NSString *filePath = nil;
    if (dataType == DataType_TimeLine) {
        filePath = [[NSBundle mainBundle] pathForResource:@"timeLine.plist" ofType:nil];
    }
    
    else if (dataType == DataType_DayKLine) {
        filePath = [[NSBundle mainBundle] pathForResource:@"dayKLine.plist" ofType:nil];
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary *dataDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (successBlock) {
                successBlock(dataDict);
            }
        });
    });
}

@end

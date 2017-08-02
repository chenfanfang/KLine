//
//  ChartsDetailDynamicDataModel.h
//  KLine
//
//  Created by 陈蕃坊 on 2017/8/2.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TimeLineModel;

// 显示详情的动态数据模型  （长按显示出来的数据）
@interface ChartsDetailDynamicDataModel : NSObject

/** 现在是否处于长按的状态 */
@property (nonatomic, assign) BOOL isLongPress;

/** 触摸的点(计算好的点，知己就可以绘制) */
@property (nonatomic, assign) CGPoint touchPoint;

/** TimeLineModel */
@property (nonatomic, strong) TimeLineModel *timeLineModel;

/** 所处的rect */
@property (nonatomic, assign) CGRect rect;

@end

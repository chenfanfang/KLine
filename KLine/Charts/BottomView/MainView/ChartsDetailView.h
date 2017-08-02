//
//  ChartsDetailView.h
//  KLine
//
//  Created by chenfanfang on 2017/8/1.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChartsDetailStaticDataModel, ChartsDetailDynamicDataModel;

// 显示详细信息的view 左右两边显示的静态数据指标都显示在这个view上
// 长按显示的动态数据也显示在这里
@interface ChartsDetailView : UIView

/** 显示详情的静态数据模型 */
@property (nonatomic, strong) ChartsDetailStaticDataModel *staticDataModel;

/** 显示详情的动态数据模型 */
@property (nonatomic, strong) ChartsDetailDynamicDataModel *dynamicDataModel;


//重新绘图
- (void)reDraw;

@end

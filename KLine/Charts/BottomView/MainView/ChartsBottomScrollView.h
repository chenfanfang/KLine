//
//  ChartsBottomScrollView.h
//  KLine
//
//  Created by 陈蕃坊 on 2017/7/29.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol ChartsBottomScrollViewDataSource <NSObject>
//
//@required
//
////水平方向有多少区间(用于画背景竖线)
//- (NSUInteger)numberOfSectionInHorizontal;
//
//@end

@interface ChartsBottomScrollView : UIScrollView

///** 数据源 */
//@property (nonatomic, weak) id<ChartsBottomScrollViewDataSource> dataSource;

- (void)reDrawWithData:(id)data sectionCount:(NSUInteger)sectionCount charsType:(ChartsType)chartsType;

@end

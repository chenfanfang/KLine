//
//  ChartsBottomScrollView.h
//  KLine
//
//  Created by 陈蕃坊 on 2017/7/29.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ChartsBottomScrollView : UIScrollView


- (void)reDrawWithData:(id)data sectionCount:(NSUInteger)sectionCount charsType:(KLine_Enum_ChartsType)chartsType;

@end

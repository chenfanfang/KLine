//
//  ChartsDetailView.m
//  KLine
//
//  Created by chenfanfang on 2017/8/1.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import "ChartsDetailView.h"

@implementation ChartsDetailView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat width = rect.size.width;
    CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y;
    CGFloat height = 0;
    CGRect drawRect;
    
    //=====================
    //   绘制左边、右边的数据
    //=====================
    height = (rect.size.width - KLine_Const_DateHeight) * KLine_Const_LinechartHeightRate;
    drawRect = CGRectMake(x, y, width, height);
    [self drawLeftDataWithRect:drawRect ctx:ctx];
}

//=================================================================
//                        绘制左边、右边的数据
//=================================================================
#pragma mark - 绘制左边的数据

- (void)drawLeftDataWithRect:(CGRect)rect ctx:(CGContextRef)ctx {
    
    CGFloat rectHeight = rect.size.height;
    
    //每个区间的高度
    CGFloat averageSectionHeight = rectHeight / self.chartsLineSections;
    
    //每一个像素代表的价钱
    CGFloat averagePxPrice = (self.maxPrice - self.minPrice) / (rectHeight - self.topMargin - self.bottomMargin);
    
    
    // 涨跌幅的处理
    CGFloat maxUpAndDown = self.maxPrice / self.preClosePrice - 1;
    CGFloat minUpAndDown = self.minPrice / self.preClosePrice - 1;
    //每一个像素代表的涨跌幅
    CGFloat averagePxUpAndDown = (maxUpAndDown - minUpAndDown) / (rectHeight - self.topMargin - self.bottomMargin);
    
    //===============================
    //   绘制左边价格数据、右边涨跌幅数据
    //===============================
    CGFloat price = 0;
    CGFloat upAndDown = 0;
    NSString *priceStr = nil;
    NSString *upAndDownStr = nil;
    UIColor *color = nil;
    NSDictionary *attributes = nil;
    
    for (int i = 0; i < self.chartsLineSections; i++) {
        price = self.minPrice + i * averagePxPrice * averageSectionHeight;
        upAndDown = minUpAndDown + i * averagePxUpAndDown * averageSectionHeight;
        priceStr = [NSString stringWithFormat:@"%.3f",price];
        upAndDownStr = [NSString stringWithFormat:@"%.2f%%",upAndDown];
        
        if (price < self.preClosePrice) {
            color = KLine_Color_StockFallColor;
            
        } else if (price == self.preClosePrice) {
            color = KLine_Color_GrayColor;
        } else {
            color = KLine_Color_StockRiseColor;
        }
        
//        attributes = 
        
    }
    
}

@end

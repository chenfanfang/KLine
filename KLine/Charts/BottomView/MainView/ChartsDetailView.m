//
//  ChartsDetailView.m
//  KLine
//
//  Created by chenfanfang on 2017/8/1.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import "ChartsDetailView.h"

@implementation ChartsDetailView

- (void)reDraw {
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat width = rect.size.width;
    CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y;
    CGFloat height = 0;
    CGRect drawRect;
    
    //==========================
    //   绘制折线图 左边、右边的数据
    //==========================
    height = (rect.size.height - KLine_Const_DateHeight) * KLine_Const_LinechartHeightRate;
    drawRect = CGRectMake(x, y, width, height);
    [self drawChartsLineLeftAndRightDataWithRect:drawRect ctx:ctx];
    
    //=====================
    //   绘制成交量 左边的数据
    //=====================
    height = (rect.size.height - KLine_Const_DateHeight) * (1 - KLine_Const_LinechartHeightRate);
    y = rect.size.height - height;
    drawRect = CGRectMake(x, y, width, height);
    [self drawVolumeLeftDataWithRect:drawRect ctx:ctx];
    
    
    //======================
    //   绘制长按时候显示的信息
    //======================
    if (self.isLongPress == YES) {
        [self drawTouchShowDataWithRect:rect ctx:ctx];
    }
    
}

//=================================================================
//                        绘制左边、右边的数据
//=================================================================
#pragma mark - 绘制左边的数据

- (void)drawChartsLineLeftAndRightDataWithRect:(CGRect)rect ctx:(CGContextRef)ctx {
    
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
    CGRect drawRect;
    CGFloat x = rect.origin.x;
    CGFloat y;
    CGFloat width = rect.size.width;
    CGFloat height = [KLineTool sizeWithString:@"别理我，我只是计算文字的高度" attributes:attributes].height;
    
    for (int i = 0; i < self.chartsLineSections; i++) {
        price = self.minPrice + i * averagePxPrice * averageSectionHeight;
        upAndDown = minUpAndDown + i * averagePxUpAndDown * averageSectionHeight;
        priceStr = [NSString stringWithFormat:@"%.3f",price];
        upAndDownStr = [NSString stringWithFormat:@"%.2f%%",upAndDown * 100];
        
        if (price < self.preClosePrice) {
            color = KLine_Color_StockFallColor;
            
        } else if (price == self.preClosePrice) {
            color = KLine_Color_GrayColor;
        } else {
            color = KLine_Color_StockRiseColor;
        }
        
        //左边数据
        attributes = [KLineTool getTextAttributesWithFontSize:KLine_FontSize_DetailLeftAndRightFontSize color:color alignment:NSTextAlignmentLeft];
        
        y = rectHeight - height - averageSectionHeight * i;
        drawRect = CGRectMake(x, y, width, height);
        [priceStr drawInRect:drawRect withAttributes:attributes];
        
        //右边数据
        attributes = [KLineTool getTextAttributesWithFontSize:KLine_FontSize_DetailLeftAndRightFontSize color:color alignment:NSTextAlignmentRight];
        [upAndDownStr drawInRect:drawRect withAttributes:attributes];
        
    }
}


//=================================================================
//                       绘制成交量 左边的数据
//=================================================================
#pragma mark - 绘制成交量 左边的数据

- (void)drawVolumeLeftDataWithRect:(CGRect)rect ctx:(CGContextRef)ctx {
    
    CGFloat rectMaxY = CGRectGetMaxY(rect);
    CGFloat rectHeight = rect.size.height;
    CGFloat sectionHeight = rectHeight / self.volumnSections;
    CGFloat averagePxValume = (self.maxVolumn - self.minVolumn) / rectHeight;
    NSString *drawStr = nil;
    NSDictionary *attributes = [KLineTool getTextAttributesWithFontSize:KLine_FontSize_DetailLeftAndRightFontSize color:KLine_Color_GrayColor alignment:NSTextAlignmentLeft];
    CGFloat fontHeight = [KLineTool sizeWithString:@"请忽略我，我只是用来计算文字高度的" attributes:attributes].height;
    NSInteger volume = 0;
    CGRect drawRect;
    CGFloat drawY = 0;
    
    for (int i = 0; i < self.volumnSections; i++) {
        drawY = rectMaxY - sectionHeight * i - fontHeight;
        volume = self.minVolumn + averagePxValume * sectionHeight * i;
        drawStr = [NSString stringWithFormat:@"%zd",volume];
        drawRect = CGRectMake(rect.origin.x, drawY, rect.size.width, fontHeight);
        
        [drawStr drawInRect:drawRect withAttributes:attributes];
    }
    
}


//=================================================================
//                      绘制长按时该显示的信息
//=================================================================
#pragma mark - 绘制长按时该显示的信息

- (void)drawTouchShowDataWithRect:(CGRect)rect ctx:(CGContextRef)ctx {
    CGFloat rectX = rect.origin.x;
    CGFloat rectY = rect.origin.y;
    CGFloat rectW = rect.size.width;
    CGFloat rectH = rect.size.height;
    CGFloat touchX = self.touchPoint.x;
    CGFloat touchY = self.touchPoint.y;
    
    CGContextSetStrokeColorWithColor(ctx, KLine_Color_GrayColor.CGColor);
    //=================
    //      横线
    //=================
    CGContextMoveToPoint(ctx, rectX, touchY);
    CGContextAddLineToPoint(ctx, rectW, touchY);
    CGContextStrokePath(ctx);
    
    //=================
    //      竖线
    //=================
    CGContextMoveToPoint(ctx, touchX, rectY);
    CGContextAddLineToPoint(ctx, touchX, rectH);
    CGContextStrokePath(ctx);
    
    
}

@end

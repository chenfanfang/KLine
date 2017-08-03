//
//  ChartsDetailView.m
//  KLine
//
//  Created by chenfanfang on 2017/8/1.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import "ChartsDetailView.h"

//model
#import "ChartsDetailStaticDataModel.h"
#import "ChartsDetailDynamicDataModel.h"
#import "TimeLineModel.h"

@implementation ChartsDetailView

//单位比例， 手 rate = 1, 万手 rate = 10000 , 亿手 rate = 100000000
static CGFloat rate;

//单位
static NSString *unit = @"股";

//=================================================================
//                           懒加载
//=================================================================
#pragma mark - 懒加载
- (ChartsDetailStaticDataModel *)staticDataModel {
    if (_staticDataModel == nil) {
        _staticDataModel = [ChartsDetailStaticDataModel new];
    }
    return _staticDataModel;
}

- (ChartsDetailDynamicDataModel *)dynamicDataModel {
    if (_dynamicDataModel == nil) {
        _dynamicDataModel = [ChartsDetailDynamicDataModel new];
    }
    return _dynamicDataModel;
}


//=================================================================
//                           绘图
//=================================================================
#pragma mark - 绘图
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
    [self drawChartsLineLeftAndRightDataWithCtx:ctx];
    
    //=====================
    //   绘制成交量 左边的数据
    //=====================
    height = (rect.size.height - KLine_Const_DateHeight) * (1 - KLine_Const_LinechartHeightRate);
    y = rect.size.height - height;
    drawRect = CGRectMake(x, y, width, height);
    [self drawVolumeLeftDataWithCtx:ctx];
    
    
    //======================
    //   绘制长按时候显示的信息
    //======================
    if (_dynamicDataModel.isLongPress == YES) {
        
        //绘制长按显示的基本数据
        [self drawTouchShowBasicDataWithCtx:ctx];
        
        //绘制显示详细信息的小蒙版
        [self drawTouchShowDetailMaskWitnCtx:ctx];
    }
    
}

//=================================================================
//                        绘制左边、右边的数据
//=================================================================
#pragma mark - 绘制左边的数据

- (void)drawChartsLineLeftAndRightDataWithCtx:(CGContextRef)ctx {
    
    //===============================
    //   绘制左边价格数据、右边涨跌幅数据
    //===============================
    CGRect rect = _staticDataModel.chartRect;
    CGFloat rectMaxY = CGRectGetMaxY(rect);
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
    
    
    for (int i = 0; i < self.staticDataModel.chartVerticalSections; i++) {
        price = _staticDataModel.minPrice + i * _staticDataModel.verticalPerPxPrice * _staticDataModel.chartVerticalPerSectionHeight;
        upAndDown = _staticDataModel.minUpAndDown + i * _staticDataModel.verticalPerPxUpAndDown * _staticDataModel.chartVerticalPerSectionHeight;
        priceStr = [NSString stringWithFormat:@"%.3f",price];
        upAndDownStr = [NSString stringWithFormat:@"%.2f%%",upAndDown * 100];
        
        if (price < _staticDataModel.prePrice) {
            color = KLine_Color_StockFallColor;
            
        } else if (price == _staticDataModel.prePrice) {
            color = KLine_Color_GrayColor;
        } else {
            color = KLine_Color_StockRiseColor;
        }
        
        //左边数据
        attributes = [KLineTool getTextAttributesWithFontSize:KLine_FontSize_DetailLeftAndRightFontSize color:color alignment:NSTextAlignmentLeft];
        
        y = rectMaxY - height - _staticDataModel.chartVerticalPerSectionHeight * i;
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

- (void)drawVolumeLeftDataWithCtx:(CGContextRef)ctx {
    CGRect rect = self.staticDataModel.volumeRect;
    CGFloat rectMaxY = CGRectGetMaxY(rect);
    NSString *drawStr = nil;
    NSDictionary *attributes = [KLineTool getTextAttributesWithFontSize:KLine_FontSize_DetailLeftAndRightFontSize color:KLine_Color_GrayColor alignment:NSTextAlignmentLeft];
    CGFloat fontHeight = [KLineTool sizeWithString:@"请忽略我，我只是用来计算文字高度的" attributes:attributes].height;
    NSInteger volume = 0;
    CGRect drawRect;
    CGFloat drawY = 0;
    
    NSString *maxVolumeStr = [NSString stringWithFormat:@"%zd",_staticDataModel.maxVolume];
    if (maxVolumeStr.length >= 9) {
        rate = 100000000;
        unit = @"亿股";
    } else if (maxVolumeStr.length >= 5) {
        rate = 10000;
        unit = @"万股";
    }
    
    for (int i = 0; i < _staticDataModel.volumeVerticalSections; i++) {
        drawY = rectMaxY - _staticDataModel.volumeVerticalPerSectionHeight * i - fontHeight;
        volume = _staticDataModel.verticalPerPxVolume * _staticDataModel.volumeVerticalPerSectionHeight * i;
        drawStr = [NSString stringWithFormat:@"%.1f",volume * 1.0 / rate];
        drawRect = CGRectMake(rect.origin.x, drawY, rect.size.width, fontHeight);
        
        if (i == 0) {
            drawStr = unit;
        }
        
        [drawStr drawInRect:drawRect withAttributes:attributes];
    }
    
}


//=================================================================
//                      绘制长按显示的基本数据
//=================================================================
#pragma mark - 绘制长按显示的基本数据

- (void)drawTouchShowBasicDataWithCtx:(CGContextRef)ctx {
    CGRect rect = self.dynamicDataModel.rect;
    CGFloat rectX = rect.origin.x;
    CGFloat rectY = rect.origin.y;
    CGFloat rectW = rect.size.width;
    CGFloat rectMaxY = CGRectGetMaxY(rect);
    CGFloat rectMaxX = CGRectGetMaxX(rect);
    CGPoint touchPoint = _dynamicDataModel.touchPoint;
    CGFloat touchX = touchPoint.x;
    CGFloat touchY = touchPoint.y;
    
    CGContextSetStrokeColorWithColor(ctx, KLine_Color_GrayColor.CGColor);
    //=================
    //      横线
    //=================
    touchY = touchY >= rectY ? touchY : rectY;
    CGContextMoveToPoint(ctx, rectX, touchY);
    CGContextAddLineToPoint(ctx, rectW, touchY);
    CGContextStrokePath(ctx);
    
    //=================
    //      竖线
    //=================
    CGContextMoveToPoint(ctx, touchX, rectY);
    CGContextAddLineToPoint(ctx, touchX, rectMaxY);
    CGContextStrokePath(ctx);
    
    //===================
    //   当前价钱的那一点
    //===================
    CGRect chartRect = _staticDataModel.chartRect;
    CGFloat pricePointX = touchX;
    CGFloat pricePointY = CGRectGetMaxY(chartRect) -  (_dynamicDataModel.timeLineModel.price - _staticDataModel.minPrice) / _staticDataModel.verticalPerPxPrice;
    CGContextSetFillColorWithColor(ctx, KLine_Color_BlueColor.CGColor);
    CGContextAddArc(ctx, pricePointX, pricePointY, KLine_Const_DetailMessagePointRadius, 0, 2 * M_PI, 0);
    CGContextFillPath(ctx);
    
    //=================
    //   当前均价的那一点
    //=================
    pricePointY = CGRectGetMaxY(chartRect) -  (_dynamicDataModel.timeLineModel.averagePrice - _staticDataModel.minPrice) / _staticDataModel.verticalPerPxPrice;
    CGContextSetFillColorWithColor(ctx, KLine_Color_TimeLineAveragePriceColor.CGColor);
    CGContextAddArc(ctx, pricePointX, pricePointY, KLine_Const_DetailMessagePointRadius, 0, 2 * M_PI, 0);
    CGContextFillPath(ctx);
    
    //=================
    //      时间
    //=================
    
    NSString *time = _dynamicDataModel.timeLineModel.time;
    NSDictionary *attributes = [KLineTool getTextAttributesWithFontSize:KLine_FontSize_TimeAndDateFontSize color:KLine_Color_GrayColor alignment:NSTextAlignmentCenter];
    CGFloat timeHeight = [KLineTool sizeWithString:time attributes:attributes].height;
    CGFloat timeWidth = KLine_Const_DetailTimeWidth;
    CGFloat timeX = touchX - timeWidth / 2.0;
    
    if (timeX < 0 || timeX > rectMaxX - timeWidth) {
        timeX = timeX < 0 ? 0:rectMaxX - timeWidth;
    }
    CGRect timeRect = CGRectMake(timeX, _dynamicDataModel.timeRect.origin.y, timeWidth, timeHeight);
    
    CGContextSetFillColorWithColor(ctx, KLine_Color_BlackColor.CGColor);
    CGContextAddRect(ctx, timeRect);
    CGContextFillPath(ctx);
    CGContextSetStrokeColorWithColor(ctx, KLine_Color_WhiteColor.CGColor);
    [time drawInRect:timeRect withAttributes:attributes];
    
    
    //==========================
    //   绘制左边的价钱、右边的涨跌幅
    //==========================
    
    //折线图区域
    CGRect chartLineRect = _staticDataModel.chartRect;
    //成交量区域
    CGRect volumeRect = _staticDataModel.volumeRect;
    CGFloat chartLineRectMaxY = CGRectGetMaxY(chartLineRect);
    CGFloat volumeRectMaY = CGRectGetMaxY(volumeRect);
    attributes = [KLineTool getTextAttributesWithFontSize:KLine_FontSize_DetailLeftAndRightFontSize color:KLine_Color_WhiteColor alignment:NSTextAlignmentCenter];
    
    CGFloat sideWidth = KLine_Const_DetailSideDataWidth;
    CGFloat fontHeight = [KLineTool sizeWithString:@"计算高度的文字，请忽略我" attributes:attributes].height;
    CGFloat sideHeight = KLine_Const_DetailSmallMaskHeight;
    CGFloat sideX = rectX;
    CGFloat sideY = touchY - sideHeight / 2.0;
    
    NSString *leftDataStr = @"0.000";
    NSString *rightDataStr = nil;
    
    //折线图部分
    if (CGRectContainsPoint(chartLineRect, touchPoint)) {
        CGFloat price = (chartLineRectMaxY - touchY) * _staticDataModel.verticalPerPxPrice + _staticDataModel.minPrice;
        CGFloat upAndDown = (chartLineRectMaxY - touchY) * _staticDataModel.verticalPerPxUpAndDown + _staticDataModel.minUpAndDown;
        leftDataStr = [NSString stringWithFormat:@"%.3f",price];
        rightDataStr = [NSString stringWithFormat:@"%.2f%%",upAndDown * 100];
        
        //记录涨跌幅度
        TimeLineModel *model = _dynamicDataModel.timeLineModel;
        model.upAndDownRate = rightDataStr;
        
        //计算涨跌幅
        model.upAndDown = model.price - _staticDataModel.prePrice;
    }
    
    //成交量部分
    else if (CGRectContainsPoint(volumeRect, touchPoint)) {
    
        CGFloat volume = 1.0 * (volumeRectMaY - touchY) * _staticDataModel.verticalPerPxVolume / rate;
        leftDataStr = [NSString stringWithFormat:@"%.1f",volume];
    }
    
    //绘制左边
    CGContextSetFillColorWithColor(ctx, KLine_Color_BlackColor.CGColor);
    CGRect leftSideRect = CGRectMake(sideX, sideY, sideWidth, sideHeight);
    CGContextAddRect(ctx, leftSideRect);
    CGContextFillPath(ctx);
    
    leftSideRect.origin.y = (sideHeight - fontHeight) / 2.0 + sideY;
    [leftDataStr drawInRect:leftSideRect withAttributes:attributes];
    
    //绘制右边
    if (rightDataStr.length) {
        CGContextSetFillColorWithColor(ctx, KLine_Color_BlackColor.CGColor);
        CGRect rightSideRect = CGRectMake(rectMaxX - sideWidth, sideY, sideWidth, sideHeight);
        CGContextAddRect(ctx, rightSideRect);
        CGContextFillPath(ctx);
        
        rightSideRect.origin.y = (sideHeight - fontHeight) / 2.0 + sideY;
        [rightDataStr drawInRect:rightSideRect withAttributes:attributes];
    }
}

//=================================================================
//                      绘制显示详细信息的小蒙版
//=================================================================
#pragma mark - 绘制显示详细信息的小蒙版

- (void)drawTouchShowDetailMaskWitnCtx:(CGContextRef)ctx {
    CGRect chartRect = _staticDataModel.chartRect;
    CGFloat chartWidth = chartRect.size.width;
    CGFloat chartX = chartRect.origin.x;
    CGFloat touchX = _dynamicDataModel.touchPoint.x;
    static CGFloat x;
    CGFloat y = chartRect.origin.y;
    CGFloat height;
    CGFloat width = KLine_Const_DetailMessageMaskWidth;
    NSDictionary *attributes = [KLineTool getTextAttributesWithFontSize:KLine_FontSize_DetailMessageMaskFontSize color:KLine_Color_WhiteColor alignment:NSTextAlignmentLeft];
    
    CGFloat fontHeight = [KLineTool sizeWithString:@"我是计算字体的高度，不要理我" attributes:attributes].height;
    NSArray *titlesArr = [self getTitleArr];
    NSArray *valuesArr = [self getValuesArr];
    height = (fontHeight + KLine_Const_DetailMessageMaskMarginAndPadding) * titlesArr.count + KLine_Const_DetailMessageMaskMarginAndPadding;
    
    CGFloat leftX = chartX;
    CGFloat rightX = chartWidth - width;
    
    //第一次显示 的位置的处理 （左边、右边）
    
    if (_dynamicDataModel.isShowFirstValue) {
        x = (chartWidth / 2.0 > touchX) ? rightX : leftX;
    }
    
    //设置一个距离
    static const CGFloat distance =  30;
    //判断在左边判断是否会被遮挡
    if ( x == leftX && (width + distance > touchX)) {
        x = rightX;
        
    }
    
    //判断在右边判断是否会被遮挡
    else if (x == rightX && (chartWidth - width - distance) < touchX ) {
        x = leftX;
    }
    
    CGRect rect = CGRectMake(x, y, width, height);
    
    //填充
    CGContextSetFillColorWithColor(ctx, KLine_Color_DarkGrayColor.CGColor);
    CGContextAddRect(ctx, rect);
    CGContextFillPath(ctx);
    
    //绘制边框
    CGContextSetStrokeColorWithColor(ctx, KLine_Color_BlackColor.CGColor);
    CGContextAddRect(ctx, rect);
    CGContextStrokePath(ctx);
    
    //绘制文字内容
    CGRect textRect;
    //添加一点边距
    CGFloat textX = x + KLine_Const_DetailMessageMaskMarginAndPadding;
    CGFloat textY;
    CGFloat textH = fontHeight;
    //给左右留点间距
    CGFloat textW = width - KLine_Const_DetailMessageMaskMarginAndPadding * 2;
    NSString *title;
    NSString *value;
    
    //涨跌幅
    CGFloat upAndDown = [valuesArr[4] floatValue];
    UIColor *stockColor = KLine_Color_WhiteColor;
    if (upAndDown > 0) {
        stockColor = KLine_Color_StockRiseColor;
    } else if (upAndDown < 0) {
        stockColor = KLine_Color_StockFallColor;
    }
    UIColor *valueColor;
    
    for (int i = 0; i < titlesArr.count; i++) {
        textY = y + (fontHeight + KLine_Const_DetailMessageMaskMarginAndPadding) * i + KLine_Const_DetailMessageMaskMarginAndPadding;
    
        textRect = CGRectMake(textX, textY, textW, textH);
        title = titlesArr[i];
        
        //绘制title
        attributes = [KLineTool getTextAttributesWithFontSize:KLine_FontSize_DetailMessageMaskFontSize color:KLine_Color_WhiteColor alignment:NSTextAlignmentLeft];
        [title drawInRect:textRect withAttributes:attributes];
        
        //绘制value
        value = valuesArr[i];
        if (i > 1 && i < 5) {
            valueColor = stockColor;
        } else {
            valueColor = KLine_Color_WhiteColor;
        }
        attributes = [KLineTool getTextAttributesWithFontSize:KLine_FontSize_DetailMessageMaskFontSize color:valueColor alignment:NSTextAlignmentRight];
        [value drawInRect:textRect withAttributes:attributes];
        
    }
    
}


//=================================================================
//                           other
//=================================================================
#pragma mark - other

//获取详细信息的所有标题
- (NSArray *)getTitleArr {
    
    NSArray *titleArr = @[
                          @"时间",
                          @"价格",
                          @"均价",
                          @"涨跌额",
                          @"涨跌幅",
                          @"成交量",
                          @"成交额"
                          ];
    return titleArr;
}

- (NSArray *)getValuesArr {
    TimeLineModel *model = _dynamicDataModel.timeLineModel;
    
    NSString *time = [NSString stringWithFormat:@"%@ %@",_dynamicDataModel.date, model.time];
    NSString *price = [NSString stringWithFormat:@"%.3f",model.price];
    NSString *averagePrice = [NSString stringWithFormat:@"%.3f",model.averagePrice];
    NSString *upAndDownRate = model.upAndDownRate;
    NSString *upAndDown = [NSString stringWithFormat:@"%.3f",model.upAndDown];
    NSString *volume = [NSString stringWithFormat:@"%.1f%@",model.amount / rate, unit];
    
    CGFloat totalMoney = model.totalMoney;
    NSString *totalMoneyStr = [NSString stringWithFormat:@"%.3f",totalMoney];
    if (totalMoney > 10000) {
        totalMoneyStr = [NSString stringWithFormat:@"%.3f万",totalMoney / 10000.0];
    } else if (totalMoney > 100000000) {
        totalMoneyStr = [NSString stringWithFormat:@"%.3f亿",totalMoney / 100000000.0];
    }
    
    NSArray *valuesArr = @[
                           time.length ? time: @"",
                           price.length ? price: @"",
                           averagePrice.length ? averagePrice: @"",
                           upAndDownRate.length ? upAndDownRate: @"",
                           upAndDown.length ? upAndDown: @"",
                           volume.length ? volume: @"",
                           totalMoneyStr.length ? totalMoneyStr: @""
                           ];
    return valuesArr;
}



@end

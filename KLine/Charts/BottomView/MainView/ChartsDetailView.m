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

@implementation ChartsDetailView

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
        [self drawTouchShowDataWithRect:rect ctx:ctx];
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
    
    for (int i = 0; i < _staticDataModel.volumeVerticalSections; i++) {
        drawY = rectMaxY - _staticDataModel.volumeVerticalPerSectionHeight * i - fontHeight;
        volume = _staticDataModel.minVolume + _staticDataModel.verticalPerPxVolume * _staticDataModel.volumeVerticalPerSectionHeight * i;
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
    CGFloat touchX = _dynamicDataModel.touchPoint.x;
    CGFloat touchY = _dynamicDataModel.touchPoint.y;
    
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

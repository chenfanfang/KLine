//
//  ChartsTopView.m
//  KLine
//
//  Created by 陈蕃坊 on 2017/7/29.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import "ChartsTopView.h"

@interface ChartsTopView()

/** 股票信息 */
@property (nonatomic, strong) NSDictionary *stockMessage;

@end

@implementation ChartsTopView


//=================================================================
//                           绘图
//=================================================================
#pragma mark - 绘图

- (void)redrawWithStockMessage:(id)stockMessage {
    self.stockMessage = stockMessage;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //==================
    //   绘制股票基本信息
    //==================
    CGFloat height = rect.size.height - KLine_Const_SelecteTypeHeight;
    CGRect stockRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, height);
    [self drawStockMessageWithRect:stockRect ctx:ctx];
    
}

//=================================================================
//                        绘制股票基本信息
//=================================================================
#pragma mark - 绘制股票基本信息
- (void)drawStockMessageWithRect:(CGRect)rect ctx:(CGContextRef)ctx {
    
    NSDictionary *attributes_White_BigFont = @{
                                               NSForegroundColorAttributeName : KLine_Color_WhiteColor,
                                               NSFontAttributeName : [UIFont systemFontOfSize:KLine_Const_StockMsgBigFontSize]
                                               };
    
    //分成两部分
    CGFloat averageHeight = rect.size.height / 2.0;
    
    //01398.HK 工商银行  5.480
    
    
//    [@"dd" drawInRect:<#(CGRect)#> withAttributes:<#(nullable NSDictionary<NSString *,id> *)#>]
    
}


//=================================================================
//                         计算文字的尺寸
//=================================================================
#pragma mark - 计算文字的尺寸

- (CGSize)sizeWithString:(NSString *)str {
    
    return CGSizeZero;
}




@end

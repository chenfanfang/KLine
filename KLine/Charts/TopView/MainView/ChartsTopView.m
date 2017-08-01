//
//  ChartsTopView.m
//  KLine
//
//  Created by 陈蕃坊 on 2017/7/29.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import "ChartsTopView.h"

//view
#import "ChartsTopSelectView.h"

@interface ChartsTopView()

/** 股票信息 */
@property (nonatomic, strong) NSDictionary *stockMessage;

/** 头部选择的view */
@property (nonatomic, weak) ChartsTopSelectView *selectView;

@end

@implementation ChartsTopView

//=================================================================
//                           懒加载
//=================================================================
#pragma mark - 懒加载
- (ChartsTopSelectView *)selectView {
    if (_selectView == nil) {
        ChartsTopSelectView *selectView = [ChartsTopSelectView new];
        selectView.titlesArr = @[
                                 @"分时",
                                 @"多日",
                                 @"日K",
                                 @"周K",
                                 @"月K",
                                 @"1分",
                                 @"5分",
                                 @"15分",
                                 @"30分",
                                 @"60分"
                                 ];
        [self addSubview:selectView];
        [selectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self);
            make.height.mas_equalTo(KLine_Const_SelecteTypeHeight);
        }];
        _selectView = selectView;
    }
    return _selectView;
}

//=================================================================
//                           绘图
//=================================================================
#pragma mark - 绘图

- (void)reDrawWithStockMessage:(id)stockMessage {
    if (stockMessage == nil) {
        return;
    }
    self.stockMessage = stockMessage;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    if (self.stockMessage == nil) {
        return;
    }
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //==================
    //   绘制股票基本信息
    //==================
    CGFloat height = rect.size.height - KLine_Const_SelecteTypeHeight;
    CGRect stockRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, height);
    [self drawStockMessageWithRect:stockRect ctx:ctx];
    
    //初始化selectView
    [self selectView];
    
    
    
}

//=================================================================
//                        绘制股票基本信息
//=================================================================
#pragma mark - 绘制股票基本信息


- (void)drawStockMessageWithRect:(CGRect)rect ctx:(CGContextRef)ctx {
    
    CGFloat bigMargin = 30;
    CGFloat smallMargin = 10;
    NSDictionary *stockMsg = self.stockMessage[@"data"];
    NSDictionary *attributes = nil;
    //根据涨跌平的颜色
    UIColor *stockColor = nil;
    //颜色临时变量
    UIColor *tempColor = nil;
    //记录股票相关的值
    NSString *value = nil;
    //股票涨跌平状态
    KLine_Enum_StockHighsAndLows stockStatus;
    if ([stockMsg[@"highAndLow"] floatValue] == 0) {
        stockStatus = KLine_Enum_StockHighsAndLows_Flat;
        stockColor = KLine_Color_GrayColor;
        
    } else if ([stockMsg[@"highAndLow"] floatValue] < 0) {
        stockStatus = KLine_Enum_StockHighsAndLows_Lows;
        stockColor = KLine_Color_StockFallColor;
        
    } else {
        stockStatus = KLine_Enum_StockHighsAndLows_Hights;
        stockColor = KLine_Color_StockRiseColor;
    }
    
    //昨收价
    CGFloat preClosePrice = [stockMsg[@"preClosePrice"] floatValue];
    
    
    //需要绘制的文字
    NSString *str = nil;
    CGFloat x = 0;
    CGFloat widthFlag = 0;
    //记录最大号字的高度（也就是01398.HK 工商银行 5.470）
    CGFloat maxFontHeight = 0;
    //第一行小字体的y值
    CGFloat firstLineSmallFontY = 0;
    CGFloat y = 0;
    CGSize textSize;
    CGRect textRect;
    
    //分成两部分
    CGFloat averageHeight = rect.size.height / 2.0;
    
    //=============================
    //   01398.HK 工商银行  5.480
    //=============================
    //01398.HK 工商银行
    str = [NSString stringWithFormat:@"%@ %@",stockMsg[@"securityCode"], stockMsg[@"name"]];
    attributes = [self getTextAttributesWithFontSize:KLine_FontSize_StockMsgBigFontSize color:KLine_Color_WhiteColor alignment:NSTextAlignmentLeft];
    textSize = [self sizeWithString:str attributes:attributes];
    maxFontHeight = textSize.height;
    textRect = CGRectMake(x, y, textSize.width, textSize.height);
    [str drawInRect:textRect withAttributes:attributes];
    x = textSize.width;
    
    //5.480
    x += bigMargin;
    str = stockMsg[@"lastPrice"];
    attributes = [self getTextAttributesWithFontSize:KLine_FontSize_StockMsgBigFontSize color:stockColor alignment:NSTextAlignmentLeft];
    textSize = [self sizeWithString:str attributes:attributes];
    textRect = CGRectMake(x, y, textSize.width, textSize.height);
    [str drawInRect:textRect withAttributes:attributes];
    
    widthFlag = x + textSize.width;
    
    //====================================
    //   已收盘 07/31 16:09 +0.050 +0.92%
    //====================================
    y = averageHeight;
    x = 20;
    
    //已收盘 07/31 16:09
    str = [NSString stringWithFormat:@"%@ %@",stockMsg[@"tradeStatusDescr"], stockMsg[@"tradingDay"]];
    attributes = [self getTextAttributesWithFontSize:KLine_FontSize_StockMsgSmallFontSize color:KLine_Color_GrayColor alignment:NSTextAlignmentLeft];
    textSize = [self sizeWithString:str attributes:attributes];
    textRect = CGRectMake(x, y, textSize.width, textSize.height);
    [str drawInRect:textRect withAttributes:attributes];
    
    //搜索的图标
    UIImage *searchImg = [UIImage imageNamed:@"icon_search.png"];
    [searchImg drawInRect:CGRectMake(0, y, textSize.height, textSize.height)];
    
    
    //+0.050 +0.92%   （代表  涨跌额、涨跌幅）
    str = stockStatus == KLine_Enum_StockHighsAndLows_Hights?
                [NSString stringWithFormat:@"+%@ +%@%%",stockMsg[@"highAndLow"], stockMsg[@"highAndLowLimited"]] :
                [NSString stringWithFormat:@"%@ %@%%",stockMsg[@"highAndLow"], stockMsg[@"highAndLowLimited"]];
    attributes = [self getTextAttributesWithFontSize:KLine_FontSize_StockMsgSmallFontSize color:stockColor alignment:NSTextAlignmentRight];
    textRect = CGRectMake(0, y, widthFlag, textSize.height);
    [str drawInRect:textRect withAttributes:attributes];
    
    x = widthFlag + bigMargin;
    y = 0;
    
    //=================
    //    最高 5.500
    //=================
    //最高
    value = stockMsg[@"highPrice"];
    str = [NSString stringWithFormat:@"最高  %@",value];
    attributes = [self getTextAttributesWithFontSize:KLine_FontSize_StockMsgSmallFontSize color:KLine_Color_GrayColor alignment:NSTextAlignmentLeft];
    textSize = [self sizeWithString:str attributes:attributes];
    firstLineSmallFontY = (maxFontHeight - textSize.height) / 2.0;
    y = firstLineSmallFontY;
    textRect = CGRectMake(x, y, textSize.width, textSize.height);
    
    attributes = [self getTextAttributesWithFontSize:KLine_FontSize_StockMsgSmallFontSize color:KLine_Color_GrayColor alignment:NSTextAlignmentLeft];
    str = @"最高";
    [str drawInRect:textRect withAttributes:attributes];
    
    //5.500
    str = value;
    attributes = [self getTextAttributesWithFontSize:KLine_FontSize_StockMsgSmallFontSize color:stockColor alignment:NSTextAlignmentRight];
    [str drawInRect:textRect withAttributes:attributes];
    
    
    //=================
    //   最低  5.420
    //=================
    //最低
    y = averageHeight;
    str = @"最低";
    textRect.origin.y = y;
    attributes = [self getTextAttributesWithFontSize:KLine_FontSize_StockMsgSmallFontSize color:KLine_Color_GrayColor alignment:NSTextAlignmentLeft];
    [str drawInRect:textRect withAttributes:attributes];
    
    //5.420
    value = stockMsg[@"lowPrice"];
    str = value;
    if ([value floatValue] > preClosePrice) { //红
        tempColor = KLine_Color_StockRiseColor;
    } else if ([value floatValue] == preClosePrice) { //灰
        tempColor = KLine_Color_GrayColor;
    } else { //绿
        tempColor = KLine_Color_StockFallColor;
    }
    attributes = [self getTextAttributesWithFontSize:KLine_FontSize_StockMsgSmallFontSize color:tempColor alignment:NSTextAlignmentRight];
    [str drawInRect:textRect withAttributes:attributes];
    
    y = firstLineSmallFontY;
    x = x + textSize.width + smallMargin;
    
    
    //=================
    //    今开 5.500
    //=================
    //今开
    value = stockMsg[@"openPrice"];
    str = [NSString stringWithFormat:@"今开  %@",value];
    attributes = [self getTextAttributesWithFontSize:KLine_FontSize_StockMsgSmallFontSize color:KLine_Color_GrayColor alignment:NSTextAlignmentLeft];
    textSize = [self sizeWithString:str attributes:attributes];
    textRect = CGRectMake(x, y, textSize.width, textSize.height);
    
    attributes = [self getTextAttributesWithFontSize:KLine_FontSize_StockMsgSmallFontSize color:KLine_Color_GrayColor alignment:NSTextAlignmentLeft];
    str = @"今开";
    [str drawInRect:textRect withAttributes:attributes];
    
    //5.500
    if (value.floatValue > preClosePrice) { //红
        tempColor = KLine_Color_StockRiseColor;
        
    } else if (value.floatValue == preClosePrice) { //灰
        tempColor = KLine_Color_GrayColor;
        
    } else { //绿
        tempColor = KLine_Color_StockFallColor;
    }
    str = value;
    attributes = [self getTextAttributesWithFontSize:KLine_FontSize_StockMsgSmallFontSize color:tempColor alignment:NSTextAlignmentRight];
    [str drawInRect:textRect withAttributes:attributes];
    
    
    //=================
    //   昨收  5.420
    //=================
    //昨收
    y = averageHeight;
    str = @"昨收";
    textRect.origin.y = y;
    attributes = [self getTextAttributesWithFontSize:KLine_FontSize_StockMsgSmallFontSize color:KLine_Color_GrayColor alignment:NSTextAlignmentLeft];
    [str drawInRect:textRect withAttributes:attributes];
    
    //5.420
    value = stockMsg[@"preClosePrice"];
    str = value;
    attributes = [self getTextAttributesWithFontSize:KLine_FontSize_StockMsgSmallFontSize color:KLine_Color_WhiteColor alignment:NSTextAlignmentRight];
    [str drawInRect:textRect withAttributes:attributes];
    
    y = firstLineSmallFontY;
    x = x + textSize.width + smallMargin;
    
    
    //=================
    //    成交量 2.50亿股
    //=================
    //成交量
    value = stockMsg[@"volume"];
    str = [NSString stringWithFormat:@"成交量  %@",value];
    attributes = [self getTextAttributesWithFontSize:KLine_FontSize_StockMsgSmallFontSize color:KLine_Color_GrayColor alignment:NSTextAlignmentLeft];
    textSize = [self sizeWithString:str attributes:attributes];
    textRect = CGRectMake(x, y, textSize.width, textSize.height);
    
    attributes = [self getTextAttributesWithFontSize:KLine_FontSize_StockMsgSmallFontSize color:KLine_Color_GrayColor alignment:NSTextAlignmentLeft];
    str = @"成交量";
    [str drawInRect:textRect withAttributes:attributes];
    
    str = value;
    attributes = [self getTextAttributesWithFontSize:KLine_FontSize_StockMsgSmallFontSize color:KLine_Color_WhiteColor alignment:NSTextAlignmentRight];
    [str drawInRect:textRect withAttributes:attributes];
    
    
    //=================
    //   成交额  13.66亿
    //=================
    //成交额
    y = averageHeight;
    str = @"成交额";
    textRect.origin.y = y;
    attributes = [self getTextAttributesWithFontSize:KLine_FontSize_StockMsgSmallFontSize color:KLine_Color_GrayColor alignment:NSTextAlignmentLeft];
    [str drawInRect:textRect withAttributes:attributes];
    
    //5.420
    value = stockMsg[@"turnOver"];
    str = value;
    attributes = [self getTextAttributesWithFontSize:KLine_FontSize_StockMsgSmallFontSize color:KLine_Color_WhiteColor alignment:NSTextAlignmentRight];
    [str drawInRect:textRect withAttributes:attributes];
    
    y = firstLineSmallFontY;
    x = x + textSize.width + smallMargin;
    
    

}


//=================================================================
//                         其他
//=================================================================
#pragma mark - 其他

//获取文字的尺寸
- (CGSize)sizeWithString:(NSString *)str attributes:(NSDictionary *)Attributes {
    CGSize size = [str boundingRectWithSize:CGSizeMake(1000, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:Attributes context:nil].size;
    
    return size;
}


//获取文字的属性
- (NSDictionary *)getTextAttributesWithFontSize:(CGFloat)fontSize color:(UIColor *)color alignment:(NSTextAlignment)alignment {
    
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = alignment;
    
    NSDictionary *attributes = @{
                                NSForegroundColorAttributeName : color,
                                NSFontAttributeName : [UIFont systemFontOfSize:fontSize],
                                NSParagraphStyleAttributeName:paragraphStyle
                                };
    
    return attributes;
    
}




@end

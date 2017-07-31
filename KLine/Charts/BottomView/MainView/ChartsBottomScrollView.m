//
//  ChartsBottomScrollView.m
//  KLine
//
//  Created by 陈蕃坊 on 2017/7/29.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import "ChartsBottomScrollView.h"

//view
#import "LinechartView.h"
#import "VolumeView.h"
#import "ChartsContentView.h"

//model
#import "TimeLineTotalModel.h"

@interface ChartsBottomScrollView()

///** 在水平方向区间的个数(用来绘画竖线) */
//@property (nonatomic, assign) <#type#> <#name#>;

/** 上部分的折线图(也就是k线图) */
//@property (nonatomic, weak) LinechartView *linechartView;
//
///** 下部分的成交量的图 */
//@property (nonatomic, weak) VolumeView *volumeView;


/** 区间数(用于画竖线) */
@property (nonatomic, assign) NSUInteger sectionCount;

/** k线内容容器view */
@property (nonatomic, weak) ChartsContentView *contentView;

/** 分时图的数据模型 */
@property (nonatomic, strong) TimeLineTotalModel *timeLineTotalModel;

/** 图标类型 */
@property (nonatomic, assign) KLine_Enum_ChartsType chartsType;

@end

@implementation ChartsBottomScrollView


//- (void)drawRect:(CGRect)rect {
//    [super drawRect:rect];
//    
//    if (self.sectionCount == 0) {
//        return;
//    }
//    
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
//    CGContextSetLineWidth(ctx, 1);
//    CGContextStrokePath(ctx);
//    
//    //港股的交易时间 9:30 - 11:30   13:00 - 16:00 共330分钟
//    //根据区间个数，绘制竖线
//    CGFloat averageWidth = rect.size.width / self.sectionCount;
//    CGFloat height = rect.size.height;
//    CGFloat x;
//    
//    for (int i = 1; i < self.sectionCount; i++) {
//        x = averageWidth * i;
//        CGContextMoveToPoint(ctx, x, 0);
//        CGContextAddLineToPoint(ctx, x, height);
//        CGContextStrokePath(ctx);
//    }
//    
//}


- (void)reDrawWithData:(id)data sectionCount:(NSUInteger)sectionCount charsType:(KLine_Enum_ChartsType)chartsType{
    
    self.timeLineTotalModel = data;
    self.sectionCount = sectionCount;
    self.chartsType = chartsType;
    [self.contentView reDrawWithLineData:data chartsType:chartsType];
    
    [self setNeedsDisplay];
}


//=================================================================
//                              初始化
//=================================================================
#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        [self linechartView];
//        [self volumeView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    
//    self.linechartView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * LinechartHeightRate);
//    
//    self.volumeView.frame = CGRectMake(0, self.frame.size.height * LinechartHeightRate, self.frame.size.width, self.frame.size.height * (1 - LinechartHeightRate));
    
}

//=================================================================
//                           懒加载
//=================================================================
#pragma mark - 懒加载

- (ChartsContentView *)contentView {
    if (_contentView == nil) {
        ChartsContentView *contentView = [[ChartsContentView alloc] init];
        [self addSubview:contentView];
        _contentView = contentView;
        _contentView.backgroundColor = [UIColor clearColor];
//        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self);
//            make.left.mas_equalTo(self).offset(KLine_Const_Margin);
//            make.bottom.mas_equalTo(self).offset(-KLine_Const_Margin);
//            make.right.mas_equalTo(self).offset(-KLine_Const_Margin);
//        }];
    }
    
    return _contentView;
}

//- (LinechartView *)linechartView {
//    if (_linechartView == nil) {
//        LinechartView *linechartView = [[LinechartView alloc] init];
//        [self addSubview:linechartView];
//        _linechartView = linechartView;
//        linechartView.backgroundColor = [UIColor clearColor];
//        
//        
//    }
//    return _linechartView;
//}
//
//- (VolumeView *)volumeView {
//    if (_volumeView == nil) {
//        VolumeView *volumeView = [[VolumeView alloc] init];
//        [self addSubview:volumeView];
//        _volumeView = volumeView;
//        
//    }
//    return _volumeView;
//}



@end

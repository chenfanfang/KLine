//
//  ChartsBottomScrollView.m
//  KLine
//
//  Created by 陈蕃坊 on 2017/7/29.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import "ChartsBottomScrollView.h"

//view
#import "ChartsContentView.h"

//model
#import "TimeLineTotalModel.h"

@interface ChartsBottomScrollView()


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


- (void)reDrawWithData:(id)data sectionCount:(NSUInteger)sectionCount charsType:(KLine_Enum_ChartsType)chartsType{
    
    self.timeLineTotalModel = data;
    self.sectionCount = sectionCount;
    self.chartsType = chartsType;
    [self.contentView reDrawWithLineData:data chartsType:chartsType];
    
    [self setNeedsDisplay];
}



- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
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
    }
    
    return _contentView;
}


@end

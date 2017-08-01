//
//  KLineMainView.m
//  KLine
//
//  Created by 陈蕃坊 on 2017/7/29.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import "ChartsMainView.h"

//third
#import <Masonry.h>

//view
#import "ChartsTopView.h"
#import "ChartsBottomScrollView.h"
#import "ChartsDetailView.h"

@interface ChartsMainView()

/** 上部分(股票的基本信息、选择k线图的类型的view：分时、日K) */
@property (nonatomic, weak) ChartsTopView *topView;

/** 下部分(绘画k线图部分) */
@property (nonatomic, weak) ChartsBottomScrollView *bottomView;

/** 显示详细信息的view */
@property (nonatomic, weak) ChartsDetailView *detailView;

/** 图标类型(分时、日K、周K....) */
@property (nonatomic, assign) KLine_Enum_ChartsType chartsType;

@end

@implementation ChartsMainView


//=================================================================
//                              初始化
//=================================================================
#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = KLine_Color_BackgroundColor;
        
        [self topView];
        
        [self detailView];
        
        [self bottomView];
        
        [self bringSubviewToFront:self.detailView];
        
    }
    
    return self;
}


//=================================================================
//                           懒加载
//=================================================================
#pragma mark - 懒加载

- (ChartsTopView *)topView {
    if (_topView == nil) {
        ChartsTopView *topView = [ChartsTopView new];
        topView.backgroundColor = KLine_Color_BackgroundColor;
        [self addSubview:topView];
        _topView = topView;
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(KLine_Const_TopViewHeight);
            
            make.left.mas_equalTo(self).offset(KLine_Const_Margin);
            make.right.mas_equalTo(self).offset(-KLine_Const_Margin);
            make.top.mas_equalTo(self).offset(KLine_Const_Margin);
        }];
    }
    
    return _topView;
}

- (ChartsBottomScrollView *)bottomView {
    if (_bottomView == nil) {
        ChartsBottomScrollView *bottomView = [[ChartsBottomScrollView alloc] init];
        [self addSubview:bottomView];
        _bottomView = bottomView;
//        _bottomView.contentSize = CGSizeMake(1000, 1000);
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topView.mas_bottom);
            make.left.mas_equalTo(self).offset(KLine_Const_Margin);
            make.right.mas_equalTo(self).offset(-KLine_Const_Margin);
            make.bottom.mas_equalTo(self).offset(-KLine_Const_Margin);
        }];
        _bottomView.backgroundColor = KLine_Color_BackgroundColor;
        
        
    }
    return _bottomView;
}

- (ChartsDetailView *)detailView {
    if (_detailView == nil) {
        ChartsDetailView *detailView = [[ChartsDetailView alloc] init];
        [self addSubview:detailView];
        _detailView = detailView;
        [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topView.mas_bottom).offset(KLine_Const_MAHeight);
            make.left.mas_equalTo(self).offset(KLine_Const_Margin);
            make.right.mas_equalTo(self).offset(-KLine_Const_Margin);
            make.bottom.mas_equalTo(self).offset(-KLine_Const_Margin);
        }];
        
        //取消交互，让点击事件穿透
        detailView.userInteractionEnabled = NO;
    }
    return _detailView;
}


//=================================================================
//                          刷新数据
//=================================================================
#pragma mark - 刷新数据
- (void)reloadData {
    KLine_Enum_ChartsType type;
    id data;
    id stockMessage;
    
    type = [self.dataSource chartsTypeInKLineMainView:self];
    data = [self.dataSource dataInKLineMainView:self];
    stockMessage = [self.dataSource stockMessageInKLineMainView:self];
    
    [self.topView reDrawWithStockMessage:stockMessage];
    [self.bottomView reDrawWithData:data sectionCount:10 charsType:type];
}

@end

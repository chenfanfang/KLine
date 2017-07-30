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

@interface ChartsMainView()

/** 上部分(股票的基本信息、选择k线图的类型的view：分时、日K) */
@property (nonatomic, weak) ChartsTopView *topView;

/** 下部分(绘画k线图部分) */
@property (nonatomic, weak) ChartsBottomScrollView *bottomView;

/** 图标类型(分时、日K、周K....) */
@property (nonatomic, assign) ChartsType chartsType;

@end

@implementation ChartsMainView


//=================================================================
//                              初始化
//=================================================================
#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = BackgroundColor;
        
        [self topView];
        
        [self bottomView];
        
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
        topView.backgroundColor = [UIColor yellowColor];
        
        [self addSubview:topView];
        _topView = topView;
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self);
            make.height.mas_equalTo(TopViewHeight);
        }];
    }
    
    return _topView;
}

- (ChartsBottomScrollView *)bottomView {
    if (_bottomView == nil) {
        ChartsBottomScrollView *bottomView = [[ChartsBottomScrollView alloc] init];
        [self addSubview:bottomView];
        _bottomView = bottomView;
        _bottomView.contentSize = CGSizeMake(1000, 1000);
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topView.mas_bottom);
            make.left.mas_equalTo(self).offset(Margin);
            make.right.mas_equalTo(self).offset(-Margin);
            make.bottom.mas_equalTo(self).offset(-Margin);
        }];
        _bottomView.backgroundColor = BackgroundColor;
        
        
    }
    return _bottomView;
}


//=================================================================
//                          刷新数据
//=================================================================
#pragma mark - 刷新数据
- (void)reloadData {
    ChartsType type;
    id data;
    
    type = [self.dataSource chartsTypeInKLineMainView:self];
    data = [self.dataSource dataInKLineMainView:self];
    
    [self.bottomView reDrawWithData:data sectionCount:10 charsType:type];
}

@end

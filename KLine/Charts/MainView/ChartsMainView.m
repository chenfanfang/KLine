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

@interface ChartsMainView()

/** 上部分(股票的基本信息、选择k线图的类型的view：分时、日K) */
@property (nonatomic, weak) ChartsTopView *topView;

@end

@implementation ChartsMainView


//=================================================================
//                              初始化
//=================================================================
#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self topView];
        
        
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
        [self addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self);
            make.height.mas_equalTo(100);
        }];
    }
    
    return _topView
}




@end

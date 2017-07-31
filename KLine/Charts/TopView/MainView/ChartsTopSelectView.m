//
//  ChartsTopSelectView.m
//  KLine
//
//  Created by 陈蕃坊 on 2017/7/31.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import "ChartsTopSelectView.h"

@implementation ChartsTopSelectView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //底部的分割线
        UIView *halvingLine = [UIView new];
        halvingLine.backgroundColor = KLine_Color_BackgroundLineColor;
        [self addSubview:halvingLine];
        [halvingLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(-KLine_Const_Margin);
            make.right.mas_equalTo(self).offset(KLine_Const_Margin);
            make.bottom.mas_equalTo(self);
            make.height.mas_equalTo(1);
        }];
        
    }
    
    return self;
}


- (void)setTitlesArr:(NSArray<NSString *> *)titlesArr {
    if (_titlesArr || titlesArr.count == 0) {
        return;
    }
    
    _titlesArr = titlesArr;
    
    NSMutableArray *btnsArrM = [NSMutableArray array];
    for (int i = 0; i < titlesArr.count; i++) {
        NSString *btnTitle = titlesArr[i];
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btnsArrM addObject:btn];
        
    }
    
    //约束的处理
    UIButton *currentBtn;
    UIButton *nextBtn;
    for (int i = 0; i < btnsArrM.count; i++) {
        currentBtn = btnsArrM[i];
        nextBtn = i < btnsArrM.count - 1 ? btnsArrM[i + 1] : nil;
        
        //第一个按钮
        if (i == 0) {
            [currentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.bottom.mas_equalTo(self);
                make.right.mas_equalTo(nextBtn.mas_left);
                make.width.mas_equalTo(nextBtn.mas_width);
            }];
        }
        
        //最后一个按钮
        else if (i == btnsArrM.count - 1) {
            [currentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.right.bottom.mas_equalTo(self);
            }];
        }
        
        else {
            [currentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(self);
                make.right.mas_equalTo(nextBtn.mas_left);
                make.width.mas_equalTo(nextBtn.mas_width);
            }];
        }
        
    }
}

- (void)btnClick:(UIButton *)btn {
    
}

@end

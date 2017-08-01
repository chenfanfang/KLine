//
//  ChartsTopSelectView.m
//  KLine
//
//  Created by 陈蕃坊 on 2017/7/31.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import "ChartsTopSelectView.h"

@interface ChartsTopSelectView()

/** 下划线 */
@property (nonatomic, weak) UIView *underLineView;

/** 上一个按钮 */
@property (nonatomic, weak) UIButton *previousBtn;

@end

@implementation ChartsTopSelectView


//=================================================================
//                              初始化
//=================================================================
#pragma mark - 初始化

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
        
        
        //下划线
        UIView *underLineView = [[UIView alloc] init];
        underLineView.backgroundColor = KLine_Color_BlueColor;
        [self addSubview:underLineView];
        underLineView.frame = CGRectZero;
        self.underLineView = underLineView;
        
        
    }
    
    return self;
}



//=================================================================
//                            set方法
//=================================================================
#pragma mark - set方法

- (void)setTitlesArr:(NSArray<NSString *> *)titlesArr {
    
    if ((_titlesArr.count != 0 && _titlesArr.count == titlesArr.count)
        || titlesArr.count == 0) {
        return;
    }
    
    _titlesArr = titlesArr;
    
    NSMutableArray *btnsArrM = [NSMutableArray array];
    for (int i = 0; i < titlesArr.count; i++) {
        NSString *btnTitle = titlesArr[i];
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.font = [UIFont systemFontOfSize:KLine_FontSize_SelecteTypeBtnFontSize];
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        [btn setTitleColor:KLine_Color_WhiteColor forState:UIControlStateNormal];
        [btn setTitleColor:KLine_Color_BlueColor forState:UIControlStateSelected];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btnsArrM addObject:btn];
        
    }
    
    
    //约束的处理(几个按钮等宽)
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
    
    //默认聚焦到第0个按钮
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self btnClick:btnsArrM[0]];
    });
}

//=================================================================
//                           事件处理
//=================================================================
#pragma mark - 事件处理

- (void)btnClick:(UIButton *)btn {
    
    //默认一个差值，下划线的宽度比按钮的宽度少 delta
    CGFloat delta = 10;
    CGFloat btnWidth = self.frame.size.width / self.titlesArr.count;
    
    NSInteger index = btn.tag;
    
    CGFloat underLineX = btnWidth * index + delta / 2;
    CGFloat underLineW = btnWidth - delta;
    CGFloat underLineH = 2;
    CGFloat underLineY = self.frame.size.height - underLineH;
    CGRect frame = CGRectMake(underLineX, underLineY, underLineW, underLineH);
    
    
    //第一次赋值frame,无需动画
    if (self.underLineView.frame.size.width == 0) {
        self.underLineView.frame = frame;
        
        self.previousBtn.selected = NO;
        btn.selected = YES;
        self.previousBtn = btn;
    }
    
    else {
        [UIView animateWithDuration:0.25 animations:^{
            self.underLineView.frame = frame;
            
        } completion:^(BOOL finished) {
            self.previousBtn.selected = NO;
            btn.selected = YES;
            self.previousBtn = btn;
        }];
    }
    
    
}

@end

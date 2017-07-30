//
//  LinechartView.m
//  KLine
//
//  Created by 陈蕃坊 on 2017/7/29.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import "LinechartView.h"

@implementation LinechartView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (self.data == nil) {
        return;
    }
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
}

- (void)setData:(NSDictionary *)data {
    _data = data;
    [self setNeedsDisplay];
}


@end

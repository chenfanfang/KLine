//
//  KLineTool.m
//  KLine
//
//  Created by chenfanfang on 2017/8/1.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import "KLineTool.h"

@implementation KLineTool


//获取文字的尺寸
+ (CGSize)sizeWithString:(NSString *)str attributes:(NSDictionary *)Attributes {
    CGSize size = [str boundingRectWithSize:CGSizeMake(1000, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:Attributes context:nil].size;
    
    return size;
}


//获取文字的属性
+ (NSDictionary *)getTextAttributesWithFontSize:(CGFloat)fontSize color:(UIColor *)color alignment:(NSTextAlignment)alignment {
    
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

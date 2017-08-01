//
//  KLineTool.h
//  KLine
//
//  Created by chenfanfang on 2017/8/1.
//  Copyright © 2017年 DanDanLiCai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLineTool : NSObject

//=================================================================
//                         其他
//=================================================================
#pragma mark - 其他

//获取文字的尺寸
+ (CGSize)sizeWithString:(NSString *)str attributes:(NSDictionary *)Attributes;


//获取文字的属性
+ (NSDictionary *)getTextAttributesWithFontSize:(CGFloat)fontSize color:(UIColor *)color alignment:(NSTextAlignment)alignment;

@end

//
//  address.m
//  ChengFengSuDa
//
//  Created by 小熊 on 2017/1/3.
//  Copyright © 2017年 橙晓侯. All rights reserved.
//

#import "address.h"

@implementation address
MJExtensionLogAllProperties

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             // 模型属性: JSON key, MJExtension 会自动将 JSON 的 key 替换为你模型中需要的属性
             @"ID":@"id",
             };
}




- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    // 替换 NSNull => nil
    if ([oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    
    
    return oldValue;
}
@end

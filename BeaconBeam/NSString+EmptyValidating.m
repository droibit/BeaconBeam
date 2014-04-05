//
//  NSString+EmptyValidating.m
//
//  Created by kumagai on 2013/08/19.
//  Copyright (c) 2013年 kumagai. All rights reserved.
//

#import "NSString+EmptyValidating.h"

/**
 * @category NSString (EmptyValidating) 
 * @brief NSStringに空文字の確認メソッドを追加するためのカテゴリ
 *
 * @author kumagai
 */
@implementation NSString (EmptyValidating)

#pragma mark - Additional methods

/**
 * @brief 空文字かどうか確認する。
 */
- (BOOL)isEmpty {
    if(self == nil || self.length == 0) {
        return YES;
    }
    
    if(![[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        return YES;
    }
    return NO;
}
@end

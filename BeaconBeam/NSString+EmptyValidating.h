//
//  NSString+EmptyValidating.h
//
//  Created by kumagai on 2013/08/19.
//  Copyright (c) 2013年 kumagai. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/**
 * @category NSString (EmptyValidating)
 * @brief NSStringに空文字の確認メソッドを追加するためのカテゴリ
 *
 * @date 2013/08/19 新規作成
 * @author kumagai
 */
@interface NSString (EmptyValidating)

#pragma mark - Additional methods

//< 空文字かどうか確認する。
- (BOOL) isEmpty;

@end

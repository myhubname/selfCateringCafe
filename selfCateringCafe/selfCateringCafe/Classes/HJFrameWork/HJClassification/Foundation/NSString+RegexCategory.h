//
//  NSString+RegexCategory.h
//  Hardware
//
//  Created by 胡俊杰 on 2019/8/21.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (RegexCategory)


/** 根据图片名 判断是否是gif图 */
- (BOOL)isGifImage;


@end

NS_ASSUME_NONNULL_END

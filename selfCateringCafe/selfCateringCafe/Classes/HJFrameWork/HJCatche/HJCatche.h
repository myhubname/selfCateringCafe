//
//  HJCatche.h
//  MyFrameWork
//
//  Created by HJ_StyleMac on 2018/12/28.
//  Copyright © 2018 HJ_StyleMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SDWebImage/SDImageCache.h>
NS_ASSUME_NONNULL_BEGIN

@interface HJCatche : NSObject


/**
 NSUserDefault存储

 @param value 存储的值
 @param key 对应的键值
 */
void userDefaultSave(id value,NSString *key);


/**
 NSUserDefault获取
 @param key 键值
 @return 返回存储的值
 */
id userDefaultGet(NSString *key);

/**
 移除键值
 @param key 存储的键值
 */
void userDefaultRemove(NSString *key);


/**
  计算缓存,这里只做图片缓存的计算，文件缓存不计算
 */
id calculateCatche(void);


/**
 移除图片缓存
 */
void removeCatche(void);

@end

NS_ASSUME_NONNULL_END

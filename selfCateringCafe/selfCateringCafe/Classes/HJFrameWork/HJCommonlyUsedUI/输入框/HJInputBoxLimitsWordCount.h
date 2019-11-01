//
//  HJInputBoxLimitsWordCount.h
//  lawyer
//
//  Created by 胡俊杰 on 2019/1/5.
//  Copyright © 2019 HJ_StyleMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJPlaceHodelTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HJInputBoxLimitsWordCount : UIView


/**
 创建输入框容器

 @param Count 字数限制
 @param placeHodel 占位文字
 @return 返回输入框容器
 */
-(instancetype)initWithCount:(NSInteger)Count andPlaceHodel:(NSString *)placeHodel;


/** 回调 */
@property (nonatomic, copy)void(^changeBlock)(UITextView *textView);

@end

NS_ASSUME_NONNULL_END

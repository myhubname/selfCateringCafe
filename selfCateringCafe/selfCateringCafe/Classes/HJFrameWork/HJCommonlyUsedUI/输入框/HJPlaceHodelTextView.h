//
//  HJPlaceHodelTextView.h
//  YDPT-OC
//
//  Created by 嘉瑞科技有限公司 on 2018/2/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJPlaceHodelTextView : UITextView

/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;

@end

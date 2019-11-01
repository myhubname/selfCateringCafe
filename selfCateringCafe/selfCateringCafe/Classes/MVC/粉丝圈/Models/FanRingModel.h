//
//  FanRingModel.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/9/2.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kWBCellPadding 12       // cell 内边距
#define kWBCellPaddingPic 4     // cell 多张图片中间留白

#define kWBCellContentWidth (kScreenWidth - 2 * kWBCellPadding) // cell 内容宽度

@interface FanRingModel : NSObject

/** Id */
@property (nonatomic,copy) NSString *Id;

/** topic */
@property (nonatomic,copy) NSString *topic;

/** date */
@property (nonatomic,copy) NSString *date;

/** intro */
@property (nonatomic,copy) NSString *intro;

/** 图片数组 */
@property (nonatomic,copy) NSArray *cover;

/** author */
@property (nonatomic,copy) NSString *author;

/** pic */
@property (nonatomic,copy) NSString *pic;

/** url */
@property (nonatomic,copy) NSString *url;


//高度计算
@property (nonatomic, assign) CGFloat titleHeight; //标题栏高度，0为没标题栏


/** 个人资料高度 */
@property (nonatomic,assign) CGFloat userHeight;


@property (nonatomic, assign) CGFloat textHeight; //文本高度(包括下方留白)

// 图片
@property (nonatomic, assign) CGFloat picHeight; //图片高度，0为没图片
@property (nonatomic, assign) CGSize picSize;


@property (nonatomic, assign) CGFloat toolbarHeight; // 工具栏


// 总高度
@property (nonatomic, assign) CGFloat height;


@end

NS_ASSUME_NONNULL_END

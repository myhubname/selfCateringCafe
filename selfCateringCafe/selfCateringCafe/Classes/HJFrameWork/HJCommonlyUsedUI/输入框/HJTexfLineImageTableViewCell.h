//
//  HJTexfLineImageTableViewCell.h
//  lawyer
//
//  Created by 胡俊杰 on 2019/1/1.
//  Copyright © 2019 HJ_StyleMac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HJTexfLineImageTableViewCell : UITableViewCell

/**输入框*/
@property (nonatomic,strong)UITextField *texf;

/**左侧提示 */
@property (nonatomic,weak)UIButton *leftAlertBtn;

/** 输入回调 */
@property (nonatomic, copy)void(^changeBlock)(UITextField *texf);

/*线条*/
@property (nonatomic,weak) UIView *line;

@end

NS_ASSUME_NONNULL_END

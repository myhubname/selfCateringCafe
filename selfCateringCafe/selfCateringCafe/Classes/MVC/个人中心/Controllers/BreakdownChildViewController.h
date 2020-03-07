//
//  BreakdownChildViewController.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/19.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BreakdownChildViewController : UIViewController

/** type */
@property (nonatomic,copy) NSString *type;


@end

@interface BreakDownCollectionViewCell : UICollectionViewCell

/** label */
@property (nonatomic,weak) UILabel *label;

@end

NS_ASSUME_NONNULL_END

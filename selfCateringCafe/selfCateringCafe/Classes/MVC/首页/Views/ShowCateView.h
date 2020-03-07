//
//  ShowCateView.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/11/6.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^selectBlock)(NSDictionary *dic);

@interface ShowCateView : UIView

+(void)showCateRect:(CGRect)rect dataSource:(NSMutableArray *)dataSource selectedId:(NSString *)selectedId selectedBlock:(selectBlock)resultBlock;


@end

@interface cateCollectionViewCell : UICollectionViewCell

/** label */
@property (nonatomic,weak) UILabel *label;

@end


NS_ASSUME_NONNULL_END


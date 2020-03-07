//
//  HJRecommendAlertView.h
//  YDPT-OC
//
//  Created by 嘉瑞科技有限公司 on 2018/3/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ShareCollectionViewCell : UICollectionViewCell
 /*图片*/
@property(nonatomic,weak) UIImageView *shareImageView;

/*标题*/
@property(nonatomic,weak) UILabel *titleLabel;

@end
typedef void(^selectedItem)(NSDictionary *selectedDic);

@interface HJRecommendAlertView : UIView

+(void)showShareView:(NSArray *)shareItems AndSelectedItem:(selectedItem)itemBlock;

@end

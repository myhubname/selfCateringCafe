//
//  HJBaseTableview.h
//  MusicHundred
//
//  Created by HJ_StyleMac on 2018/7/23.
//  Copyright © 2018年 HJ_StyleMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJBaseTableview : UITableView


/*automaticallyAdjustsScrollViewIn*/
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style andVc:(UIViewController *)vc;

@end

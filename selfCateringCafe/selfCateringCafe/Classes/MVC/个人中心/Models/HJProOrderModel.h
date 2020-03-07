//
//  HJProOrderModel.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/10/16.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HJProOrderModel : NSObject

//"Id": "68",
//"cid": "3",
//"topic": "如何快速爆发免费流量10000+！让你日破百单！",
//"price": "0.01",
//"num": "1",
//"status": "2",
//"sn": "2019103020385425103",
//"uid": "19",
//"paytime": "2019-10-30 20:39:07",
//"pic": "20190829\/5d679078dd996.jpg",
//"phone": "133****1109",
//"userface": "default\/userface.png",
//"usernumber": "002082"

/**Id*/
@property (nonatomic,copy) NSString *Id;

/** cid */
@property (nonatomic,copy) NSString *cid;

/** topic */
@property (nonatomic,copy) NSString *topic;

/** price */
@property (nonatomic,copy) NSString *price;


/** num */
@property (nonatomic,copy) NSString *num;

/** status */
@property (nonatomic,copy) NSString *status;

/** sn */
@property (nonatomic,copy) NSString *sn;

/** uid */
@property (nonatomic,copy) NSString *uid;

/** paytime */
@property (nonatomic,copy) NSString *paytime;

/** pic */
@property (nonatomic,copy) NSString *pic;

/** phone */
@property (nonatomic,copy) NSString *phone;


/** userface */
@property (nonatomic,copy) NSString *userface;


/** usernumber */
@property (nonatomic,copy) NSString *usernumber;



@end

NS_ASSUME_NONNULL_END

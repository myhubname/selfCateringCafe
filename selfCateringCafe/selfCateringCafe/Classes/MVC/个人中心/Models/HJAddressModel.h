//
//  HJAddressModel.h
//  selfCateringCafe
//
//  Created by 胡俊杰 on 2019/11/16.
//  Copyright © 2019 胡俊杰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HJAddressModel : NSObject

/** Id */
@property (nonatomic,copy) NSString *Id;

/** address */
@property (nonatomic,copy) NSString *address;

/** cname */
@property (nonatomic,copy) NSString *cname;

/** date */
@property (nonatomic,copy) NSString *date;

/** isdefault */
@property (nonatomic,copy) NSString *isdefault;

/** phone */
@property (nonatomic,copy) NSString *phone;

/** pname */
@property (nonatomic,copy) NSString *pname;

/** rname */
@property (nonatomic,copy) NSString *rname;

/** sname */
@property (nonatomic,copy) NSString *sname;

/** tel */
@property (nonatomic,copy) NSString *tel;

/** user */
@property (nonatomic,copy) NSString *user;


@end

NS_ASSUME_NONNULL_END

//
//  IWprofileProvinceModel.h
//  Doctor
//
//  Created by 深水区 on 16/12/22.
//
//

#import <Foundation/Foundation.h>

@interface IWprofileProvinceModel : NSObject


/*
 "areaCode": "",
 "cpfAddress": "",
 "parentCode": "",
 "regionCode": "320000",
 "regionLevel": 0,
 "regionName": "江苏省",
 "socialSecurity": ""
 */

@property (nonatomic, copy) NSString *areaCode;
@property (nonatomic, copy) NSString *cpfAddress;
@property (nonatomic, copy) NSString *parentCode;
@property (nonatomic, copy) NSString *regionCode;
@property (nonatomic, strong) NSNumber *regionLevel;
@property (nonatomic, copy) NSString *regionName;
@property (nonatomic, copy) NSString *socialSecurity;



@end

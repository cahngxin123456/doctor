//
//  IWProfileCityModel.h
//  Doctor
//
//  Created by 深水区 on 16/12/22.
//
//

#import <Foundation/Foundation.h>

@interface IWProfileCityModel : NSObject

/*
 "areaCode": "0518",
 "cpfAddress": "http://search.lygzfgjj.com.cn/",
 "parentCode": "320000",
 "regionCode": "320700",
 "regionLevel": 1,
 "regionName": "连云港市",
 "socialSecurity": "http://www.12333sb.com/shebaoka/jiangsu/lianyungang.html"
 */

@property (nonatomic, copy) NSString *areaCode;
@property (nonatomic, copy) NSString *cpfAddress;
@property (nonatomic, copy) NSString *parentCode;
@property (nonatomic, copy) NSString *regionCode;
@property (nonatomic, strong) NSNumber *regionLevel;
@property (nonatomic, copy) NSString *regionName;
@property (nonatomic, copy) NSString *socialSecurity;





@end

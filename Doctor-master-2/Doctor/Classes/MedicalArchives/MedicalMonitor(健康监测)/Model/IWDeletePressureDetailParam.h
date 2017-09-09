//
//  IWDeletePressureDetailParam.h
//  Doctor
//
//  Created by 深水区 on 16/12/30.
//
//

#import <Foundation/Foundation.h>

@interface IWDeletePressureDetailParam : NSObject
/*
 /*
 {
	"bloodPressureId": "8a99880d59248ba901594dfc9a49002d",
	"companyId": "101915",
	"loginId": "2171"
 }
 */

@property (nonatomic, copy) NSString *bloodPressureId;
@property (nonatomic, strong) NSNumber *companyId;
@property (nonatomic, copy) NSString *loginId;


@end

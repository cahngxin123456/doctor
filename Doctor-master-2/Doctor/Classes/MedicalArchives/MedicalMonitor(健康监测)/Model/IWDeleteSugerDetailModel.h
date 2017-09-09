//
//  IWDeleteSugerDetailModel.h
//  Doctor
//
//  Created by 深水区 on 16/12/30.
//
//

#import <Foundation/Foundation.h>

@interface IWDeleteSugerDetailModel : NSObject

/*
 {
	"bloodSugarId": "8a99880d58ccbfa00159214cd26f003e",
	"companyId": "101915",
	"loginId": "2171"

 */

@property (nonatomic, copy) NSString *bloodSugarId;
@property (nonatomic, strong) NSNumber *companyId;
@property (nonatomic, copy) NSString *loginId;





@end

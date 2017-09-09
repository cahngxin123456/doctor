//
//  IWBloodSugerDetalModel.h
//  Doctor
//
//  Created by 深水区 on 16/12/24.
//
//

#import <Foundation/Foundation.h>

@interface IWBloodSugerDetalModel : NSObject
/*
 "id": "8a99880d5972a933015972e5876a000a",
 "insertTime": "20170106162922",
 "remark": "",
 "measureTime": "2012-02-16 04:13:56",
 "period": "午餐前",
 "usingStatus2show": "在用",
 "bloodSugar": "7.1"
 */


@property (nonatomic, copy) NSString *bloodSugerDetalID;
@property (nonatomic, copy) NSString *insertTime;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *measureTime;
@property (nonatomic, copy) NSString *period;
@property (nonatomic, copy) NSString *usingStatus2show;
@property (nonatomic, copy) NSString *bloodSugar;


@end

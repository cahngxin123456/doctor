//
//  IWBloodPressureModel.h
//  Doctor
//
//  Created by 深水区 on 16/12/24.
//
//

#import <Foundation/Foundation.h>

@interface IWBloodPressureModel : NSObject

//{
//    "code": 0,
//    "datas": {
//        "id": "8a99880d58ccbfa0015917140681002b",
//        "lowPressure": "80",
//        "remark": "",
//        "insertTime": "20161219203505",
//        "heartRate": "70",
//        "measureTime": "2011-12-29 08:19:24",
//        "highPresure": "79"
//    },
//    "info": "请求成功"
//}


@property (nonatomic, copy) NSString *pressureID;
@property (nonatomic, copy) NSString *lowPressure;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *insertTime;
@property (nonatomic, copy) NSString *heartRate;
@property (nonatomic, copy) NSString *measureTime;
@property (nonatomic, copy) NSString *highPresure;



@end

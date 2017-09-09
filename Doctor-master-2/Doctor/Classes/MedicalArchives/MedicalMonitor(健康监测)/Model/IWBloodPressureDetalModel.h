//
//  IWBloodPressureDetalModel.h
//  Doctor
//
//  Created by 深水区 on 16/12/24.
//
//

#import <Foundation/Foundation.h>

@interface IWBloodPressureDetalModel : NSObject

/*
"code": 0,
"datas": {
    "totalCount": 21,
    "pageData": [{
        "id": "8a99880d59248ba901593080f5990002",
        "insertTime": "20161224190434",
        "remark": "了看空弄弄你了解了解了解彼此彼此爸爸爸爸爸爸爸爸",
        "lowPressure": "80",
        "heartRate": "70",
        "measureTime": "2012-02-03 06:48:47",
        "highPresure": "120",
        "usingStatus2show": "在用"
    },{
        "id": "8a99880d582e69a2015837104b530002",
        "insertTime": "20161106083604",
        "remark": "",
        "lowPressure": "80",
        "heartRate": "70",
        "measureTime": "2016-11-06 08:36:06",
        "highPresure": "150",
        "usingStatus2show": "在用"
    }],
    "pageSize": 10,
    "pageNumber": 1
},
"info": "请求成功"
*/

@property (nonatomic, copy) NSString *bloodPressureDetalID;
@property (nonatomic, copy) NSString *insertTime;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *lowPressure;
@property (nonatomic, copy) NSString *heartRate;
@property (nonatomic, copy) NSString *measureTime;
@property (nonatomic, copy) NSString *highPresure;
@property (nonatomic, copy) NSString *usingStatus2show;



@end

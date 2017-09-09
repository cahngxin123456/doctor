//
//  IWBloodSugerModel.h
//  Doctor
//
//  Created by 深水区 on 16/12/24.
//
//

#import <Foundation/Foundation.h>

@interface IWBloodSugerModel : NSObject
//
//{
//    "code": 0,
//    "datas": {
//        "id": "8a99880d58ccbfa00159214cd26f003e",
//        "remark": "",
//        "insertTime": "20161221201319",
//        "measureTime": "2012-01-31 07:57:44",
//        "period": "午餐前",
//        "bloodSugar": "1.5"
//    },
//    "info": "请求成功"
//}

@property (nonatomic, copy) NSString *sugerID; // 主键
@property (nonatomic, copy) NSString *remark; // 备注
@property (nonatomic, copy) NSString *insertTime; // 提交时间
@property (nonatomic, copy) NSString *measureTime; // 测量时间
@property (nonatomic, copy) NSString *period; // 时段
@property (nonatomic, copy) NSString *bloodSugar; // 血糖值


@end

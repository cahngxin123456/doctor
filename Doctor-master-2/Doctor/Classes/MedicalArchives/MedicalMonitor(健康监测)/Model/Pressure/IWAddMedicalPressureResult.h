//
//  IWAddMedicalPressureResult.h
//  Doctor
//
//  Created by 范超 on 2017/1/7.
//
//

#import "IWBaseResult.h"
@class IWBloodPressureModel;

@interface IWAddMedicalPressureResult : IWBaseResult
@property (nonatomic, strong) IWBloodPressureModel *datas;
@end

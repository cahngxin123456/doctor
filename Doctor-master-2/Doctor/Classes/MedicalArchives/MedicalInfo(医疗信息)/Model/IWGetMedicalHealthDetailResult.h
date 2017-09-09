//
//  IWGetMedicalHealthDetailResult.h
//  Doctor
//
//  Created by 范超 on 2016/12/25.
//
//

#import "IWBaseResult.h"
#import "IWMedicalHealth.h"

@interface IWGetMedicalHealthDetailResult : IWBaseResult
@property (nonatomic, strong) IWMedicalHealth *datas;
@end

//
//  IWAddYanJiuParam.h
//  Doctor
//
//  Created by 范超 on 2016/12/26.
//
//

#import "IWBaseMedicalParam.h"

@interface IWAddYanJiuParam : IWBaseMedicalParam
@property (nonatomic, copy) NSString *smokeYear;
@property (nonatomic, copy) NSString *smokeNum;
@property (nonatomic, copy) NSString *drinkYear;
@property (nonatomic, copy) NSString *drinkNum;
@property (nonatomic, copy) NSString *wineType;
@property (nonatomic, copy) NSString *otherWineType;
@property (nonatomic, copy) NSString *noValue;

@end

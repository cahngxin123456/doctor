//
//  IWMedicalHealth.m
//  Doctor
//
//  Created by 范超 on 2016/12/25.
//
//

#import "IWMedicalHealth.h"
#import "MJExtension.h"

@implementation IWMedicalHealth
- (NSDictionary *)objectClassInArray {
    return @{@"shengyu" : [IWShengYu class],
             @"jibing" : [IWJiBing class],
             @"shoushu" : [IWJiBing class],
             @"shuxue" : [IWJiBing class],
             @"jiazuGrandPaAndMa" : [IWJiaZu class],
             @"jiazuFather" : [IWJiaZu class],
             @"jiazuMother" : [IWJiaZu class],
             @"jiazuBroAndSis" : [IWJiaZu class]
             };
}
@end

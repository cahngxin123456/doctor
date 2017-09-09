//
//  IWBloodPressureDetalModel.m
//  Doctor
//
//  Created by 深水区 on 16/12/24.
//
//

#import "IWBloodPressureDetalModel.h"

@implementation IWBloodPressureDetalModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        
        self.bloodPressureDetalID = value;
    }
}

@end

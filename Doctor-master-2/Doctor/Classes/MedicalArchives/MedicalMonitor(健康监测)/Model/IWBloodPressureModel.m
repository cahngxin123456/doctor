//
//  IWBloodPressureModel.m
//  Doctor
//
//  Created by 深水区 on 16/12/24.
//
//

#import "IWBloodPressureModel.h"

@implementation IWBloodPressureModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        
        self.pressureID = value;
        
    }
}

@end

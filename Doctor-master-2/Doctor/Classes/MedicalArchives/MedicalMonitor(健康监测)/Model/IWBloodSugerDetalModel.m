//
//  IWBloodSugerDetalModel.m
//  Doctor
//
//  Created by 深水区 on 16/12/24.
//
//

#import "IWBloodSugerDetalModel.h"

@implementation IWBloodSugerDetalModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        
        self.bloodSugerDetalID = value;
    }
}

@end

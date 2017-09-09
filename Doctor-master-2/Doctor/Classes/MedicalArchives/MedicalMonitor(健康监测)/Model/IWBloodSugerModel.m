//
//  IWBloodSugerModel.m
//  Doctor
//
//  Created by 深水区 on 16/12/24.
//
//

#import "IWBloodSugerModel.h"

@implementation IWBloodSugerModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.sugerID = value;
    }
}

@end

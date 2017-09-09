//
//  IWprofileJobModel.m
//  Doctor
//
//  Created by 深水区 on 16/12/22.
//
//

#import "IWprofileJobModel.h"

@implementation IWprofileJobModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.jobID = value;
    }
}

@end

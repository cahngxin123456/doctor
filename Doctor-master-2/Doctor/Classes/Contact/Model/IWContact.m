//
//  IWContact.m
//  Conedot
//
//  Created by 范超 on 14-10-15.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWContact.h"

@implementation IWContact
- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.type = dict[@"type"];
        self.mail = dict[@"mail"];
        self.cellphone = dict[@"cellphone"];
        self.telephone1 = dict[@"telephone1"];
        self.telephone2 = dict[@"telephone2"];
        self.telephone3 = dict[@"telephone3"];
    }
    return self;
}

+ (id)contactWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (NSArray *)phones {
    NSMutableArray *array = [NSMutableArray array];
    if (_cellphone != nil && ![_cellphone isEqualToString:@""]) {
        [array addObject:_cellphone];
    }
    
    if (_telephone1 != nil && ![_telephone1 isEqualToString:@""]) {
        [array addObject:_telephone1];
    }
    
    if (_telephone2 != nil && ![_telephone2 isEqualToString:@""]) {
        [array addObject:_telephone2];
    }
       
    if (_telephone3 != nil && ![_telephone3 isEqualToString:@""]) {
        [array addObject:_telephone3];
    }
    
    return array;
}

- (NSString *)showCellphone {
    if (_cellphone != nil || ![_cellphone isEqualToString:@""]) {
        return _cellphone;
    } else if (_telephone1 != nil || ![_telephone1 isEqualToString:@""]) {
        return _telephone1;
    } else if (_telephone2 != nil || ![_telephone2 isEqualToString:@""]) {
        return _telephone2;
    } else if (_telephone3 != nil || ![_telephone3 isEqualToString:@""]) {
        return _telephone3;
    } else {
        return NSLocalizedString(@"no_phone", nil);
    }
}
@end

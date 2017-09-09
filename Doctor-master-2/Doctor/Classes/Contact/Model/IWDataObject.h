//
//  IWDataObject.h
//  Conedot
//
//  Created by 范超 on 14-10-15.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWContact.h"

@interface IWDataObject : NSObject
@property (nonatomic, strong) IWContact *contact;
@property (nonatomic, strong) NSArray *children;
@end

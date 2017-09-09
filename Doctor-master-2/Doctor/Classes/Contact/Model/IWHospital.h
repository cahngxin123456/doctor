//
//  IWHospital.h
//  Doctor
//
//  Created by 范超 on 16/12/17.
//
//

#import <Foundation/Foundation.h>

@interface IWHospital : NSObject
@property (nonatomic, copy) NSString *hospitalId; // 员工ID
@property (nonatomic, copy) NSString *hospitalName; // 员工名称
@property (nonatomic, copy) NSString *communityId; // 部门ID
@property (nonatomic, copy) NSString *communityName; // 部门名称
@end

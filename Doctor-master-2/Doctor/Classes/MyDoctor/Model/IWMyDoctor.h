//
//  IWMyDoctor.h
//  Doctor
//
//  Created by 范超 on 2017/1/5.
//
//

#import <Foundation/Foundation.h>

@interface IWMyDoctor : NSObject
@property (nonatomic, copy) NSString *ID; // 医生信息 id
@property (nonatomic, copy) NSString *name; // 姓名
@property (nonatomic, copy) NSString *department; // 科室
@property (nonatomic, copy) NSString *title; // 职称
@property (nonatomic, copy) NSString *good; // 擅长领域
@property (nonatomic, copy) NSString *photo; // 头像
@property (nonatomic, copy) NSString *doctorType; // 签约医生类型

@end

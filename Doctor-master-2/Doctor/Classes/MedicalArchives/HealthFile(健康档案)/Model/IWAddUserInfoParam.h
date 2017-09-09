//
//  IWUserInfoParam.h
//  Doctor
//
//  Created by 范超 on 2016/12/25.
//
//

#import <Foundation/Foundation.h>

@interface IWAddUserInfoParam : NSObject

@property (nonatomic, copy) NSString *loginId; // 登录 ID
@property (nonatomic, strong) NSNumber *companyId; // 公司id
@property (nonatomic, copy) NSString *userName; // 姓名
@property (nonatomic, copy) NSString *relationship; // 关系(0 本人 1家人 2 其他人)
@property (nonatomic, copy) NSString *gender; // 性别(字典 gender)
@property (nonatomic, copy) NSString *genderRemark;// 性别 3 时的描述
@property (nonatomic, copy) NSString *birthday; // 出生日期
@property (nonatomic, copy) NSString *communityId; // 所属社区
@property (nonatomic, copy) NSString *occupation; // 职业(字典 occupation)
@property (nonatomic, copy) NSString *education; // 学历(字典 education)
@property (nonatomic, copy) NSString *maritalStatus; // 婚姻状况(字典 maritalStatus)
@property (nonatomic, copy) NSString *userCard; // 身份证号
@property (nonatomic, copy) NSString *siStatus; // 社保状态(0 无 1 有)
@property (nonatomic, copy) NSString *siPlace; // 社保所属区域
@property (nonatomic, copy) NSString *siCode; // 公积金编号
@property (nonatomic, copy) NSString *cellphone;// 手机号
@property (nonatomic, copy) NSString *mail; // 邮箱
@property (nonatomic, copy) NSString *pwd; // 密码
@property (nonatomic, copy) NSString *memberId;

@end

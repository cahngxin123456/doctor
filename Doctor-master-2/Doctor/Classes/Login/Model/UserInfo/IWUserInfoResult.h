//
//  IWUserInfoResult.h
//  Conedot
//
//  Created by 范超 on 14-10-26.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWBaseResult.h"

@interface IWUserInfoResult : IWBaseResult

@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *birthday2show;
@property (nonatomic, copy) NSString *birthplace;
@property (nonatomic, copy) NSString *birthplace2show;
@property (nonatomic, copy) NSString *cellphone;
@property (nonatomic, copy) NSString *cellphoneNew;
@property (nonatomic, copy) NSString *companyId;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *degree;
@property (nonatomic, copy) NSString *degree2show;
@property (nonatomic, copy) NSString *deptId;
@property (nonatomic, copy) NSString *deptName;
@property (nonatomic, copy) NSString *education;
@property (nonatomic, copy) NSString *education2show;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *gender2show;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *infoChangeId;
@property (nonatomic, copy) NSString *insertTime;
@property (nonatomic, copy) NSString *insertTime2show;
@property (nonatomic, copy) NSString *mail;
@property (nonatomic, copy) NSString *nation2show;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *remarkName;
@property (nonatomic, copy) NSString *telephone1;
@property (nonatomic, copy) NSString *telephone2;
@property (nonatomic, copy) NSString *telephone3;
@property (nonatomic, copy) NSString *userCard;
@property (nonatomic, copy) NSString *userDuty;
@property (nonatomic, copy) NSString *userName;
/**
mail = "test@test.com";
maritalStatus = 2;
maritalStatus2show = "\U5df2\U5a5a";
nation = 5;
nation2show = "\U7ef4\U543e\U5c14\U65cf";
parentId = 116;
photo = "";
relationFlag = 1;
relationship = 0;
remarkName = "QD->PDI";
showContent = "cellphone,mail,telephone1,telephone2,telephone3,";
showFlag = 1;
telephone1 = 111;
telephone2 = 222;
telephone3 = 333;
updateTime = 20140925144118;
updateTime2show = "2014-09-25 14:41:18";
updateTime2showBr = "2014-09-25<br>14:41:18";
updateUserId = 1;
updateUserType = 1;
userCard = 110100199010100008;
userCode = code01;
userDuty = "\U804c\U52a1";
userName = "\U6d4b\U8bd5A";
usingStatus = 1;
usingStatus2show = "\U5728\U804c";
usingStatusEnum = USING;
*/



@end

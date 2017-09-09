//
//  IWProfileInfoModel.h
//  Doctor
//
//  Created by 深水区 on 16/12/20.
//
//

#import <Foundation/Foundation.h>

@interface IWProfileInfoModel : NSObject


/*
 "birthday": "20110131",
 "loginId": 2171,
 "siPlace2show": "",
 "education": 7,
 "maritalStatus": 2,
 "nation2show": "",
 "degree2show": "",
 "education2show": "研究生",
 "cellphone": "15950000853",
 "occupation2show": "幼托儿童",
 "birthplace2show": "",
 "gender": 2,
 "userName": "范超",
 "siCode": "3648789",
 "loginName": "",
 "mail": "chao.red@gmail.com",
 "occupation": 1,
 "siStatus": 0,
 "nickname": "",
 "maritalStatus2show": "已婚",
 "photo": "http://114.55.25.162:7070/uploads/user/photo/2016/201611/20161112/20161112000205_Y9m1eL.png",
 "nation": "",
 "siPlace": "工业园区",
 "relationship": "0",
 "userCard": "362202198607175514",
 "pwd": "e10adc3949ba59abbe56e057f20f883e",
 "degree": "",
 "birthplace": "",
 "communityName": "李志青家庭医生专区",
 "gender2show": "女",
 "communityId": 2403
 */
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *birthplace;
@property (nonatomic, copy) NSString *birthplace2show;
@property (nonatomic, copy) NSString *cellphone;
@property (nonatomic, copy) NSString *communityId;
@property (nonatomic, copy) NSString *communityName;
@property (nonatomic, copy) NSString *degree;
@property (nonatomic, copy) NSString *degree2show;
@property (nonatomic, copy) NSString *education;
@property (nonatomic, copy) NSString *education2show;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *gender2show;
@property (nonatomic, copy) NSString *loginId;
@property (nonatomic, copy) NSString *loginName;
@property (nonatomic, copy) NSString *mail;
@property (nonatomic, copy) NSString *maritalStatus;
@property (nonatomic, copy) NSString *maritalStatus2show;
@property (nonatomic, copy) NSString *nation;
@property (nonatomic, copy) NSString *nation2show;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *occupation;
@property (nonatomic, copy) NSString *occupation2show;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *pwd;
@property (nonatomic, copy) NSString *relationship;
@property (nonatomic, copy) NSString *siCode;
@property (nonatomic, copy) NSString *siPlace;
@property (nonatomic, copy) NSString *siPlace2show;
@property (nonatomic, copy) NSString *siStatus;
@property (nonatomic, copy) NSString *userCard;
@property (nonatomic, copy) NSString *userName;



@end

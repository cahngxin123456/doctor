//
//  IWUser.m
//  Conedot
//
//  Created by 范超 on 14-9-26.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWUser.h"

@implementation IWUser

/**
 *  从文件中解析对象的时候调
 */
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.loginId = [decoder decodeObjectForKey:@"loginId"];
        self.loginName = [decoder decodeObjectForKey:@"loginName"];
        self.pwd = [decoder decodeObjectForKey:@"pwd"];
        self.password = [decoder decodeObjectForKey:@"password"];
        self.cellphone = [decoder decodeObjectForKey:@"cellphone"];
        self.mail = [decoder decodeObjectForKey:@"mail"];
        self.userName = [decoder decodeObjectForKey:@"userName"];
        self.communityId = [decoder decodeObjectForKey:@"communityId"];
        self.communityName = [decoder decodeObjectForKey:@"communityName"];
        self.userCard = [decoder decodeObjectForKey:@"userCard"];
        self.photo = [decoder decodeObjectForKey:@"photo"];
        self.nickname = [decoder decodeObjectForKey:@"nickname"];
        self.gender = [decoder decodeIntegerForKey:@"gender"];
        self.gender2show = [decoder decodeObjectForKey:@"gender2show"];
        self.birthday = [decoder decodeObjectForKey:@"birthday"];
        self.birthplace = [decoder decodeObjectForKey:@"birthplace"];
        self.birthplace2show = [decoder decodeObjectForKey:@"birthplace2show"];
        self.nation = [decoder decodeObjectForKey:@"nation"];
        self.nation2show = [decoder decodeObjectForKey:@"nation2show"];
        self.maritalStatus = [decoder decodeObjectForKey:@"maritalStatus"];
        self.maritalStatus2show = [decoder decodeObjectForKey:@"maritalStatus2show"];
        self.education = [decoder decodeObjectForKey:@"education"];
        self.education2show = [decoder decodeObjectForKey:@"education2show"];
        self.degree = [decoder decodeObjectForKey:@"degree"];
        self.degree2show = [decoder decodeObjectForKey:@"degree2show"];
        self.deviceToken = [decoder decodeObjectForKey:@"deviceToken"];
        self.cpf = [decoder decodeObjectForKey:@"cpf"];
        self.socialSecurity = [decoder decodeObjectForKey:@"socialSecurity"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.loginId forKey:@"loginId"];
    [encoder encodeObject:self.loginName forKey:@"loginName"];
    [encoder encodeObject:self.pwd forKey:@"pwd"];
    [encoder encodeObject:self.password forKey:@"password"];
    [encoder encodeObject:self.cellphone forKey:@"cellphone"];
    [encoder encodeObject:self.mail forKey:@"mail"];
    [encoder encodeObject:self.userName forKey:@"userName"];
    [encoder encodeObject:self.communityId forKey:@"communityId"];
    [encoder encodeObject:self.communityName forKey:@"communityName"];
    [encoder encodeObject:self.userCard forKey:@"userCard"];
    [encoder encodeObject:self.photo forKey:@"photo"];
    [encoder encodeObject:self.nickname forKey:@"nickname"];
    [encoder encodeInteger:self.gender forKey:@"gender"];
    [encoder encodeObject:self.gender2show forKey:@"gender2show"];
    [encoder encodeObject:self.birthday forKey:@"birthday"];
    [encoder encodeObject:self.birthplace forKey:@"birthplace"];
    [encoder encodeObject:self.birthplace2show forKey:@"birthplace2show"];
    [encoder encodeObject:self.nation forKey:@"nation"];
    [encoder encodeObject:self.nation2show forKey:@"nation2show"];
    [encoder encodeObject:self.maritalStatus forKey:@"maritalStatus"];
    [encoder encodeObject:self.maritalStatus2show forKey:@"maritalStatus2show"];
    [encoder encodeObject:self.education forKey:@"education"];
    [encoder encodeObject:self.education2show forKey:@"education2show"];
    [encoder encodeObject:self.degree forKey:@"degree"];
    [encoder encodeObject:self.degree2show forKey:@"degree2show"];
    [encoder encodeObject:self.deviceToken forKey:@"deviceToken"];
    [encoder encodeObject:self.cpf forKey:@"cpf"];
    [encoder encodeObject:self.socialSecurity forKey:@"socialSecurity"];
}

- (NSString *)birthplace {
    if ((NSNull *)_birthplace == [NSNull null]) {
        return @"";
    }
    return _birthplace;
}

- (NSString *)birthplace2show {
    if ((NSNull *)_birthplace2show == [NSNull null]) {
        return @"";
    }
    return _birthplace2show;
}

- (NSString *)degree {
    if ((NSNull *)_degree == [NSNull null]) {
        return @"";
    }
    return _degree;
}

- (NSString *)degree2show {
    if ((NSNull *)_degree2show == [NSNull null]) {
        return @"";
    }
    return _degree2show;
}

- (NSString *)education {
    if ((NSNull *)_education == [NSNull null]) {
        return @"";
    }
    return _education;
}

- (NSString *)education2show {
    if ((NSNull *)_education2show == [NSNull null]) {
        return @"";
    }
    return _education2show;
}

- (NSInteger)gender {
    
//    if ((NSNull *)_gender == [NSNull null]) {
//        return @"1";
//    }
    return _gender;
}

- (NSString *)gender2show {
    if ((NSNull *)_gender2show == [NSNull null]) {
        return @"";
    }
    return _gender2show;
}

- (NSString *)photo {
    if ((NSNull *)_photo == [NSNull null]) {
        return @"";
    }
    return _photo;
}

- (NSString *)userCard {
    if ((NSNull *)_userCard == [NSNull null]) {
        return @"";
    }
    return _userCard;
}

- (NSString *)userName {
    if ((NSNull *)_userName == [NSNull null]) {
        return @"";
    }
    return _userName;
}


- (NSString *)communityName {
    if ((NSNull *)_communityName == [NSNull null]) {
        return @"";
    }
    return _communityName;
}


- (NSString *)communityId {
    if ((NSNull *)_communityId == [NSNull null]) {
        return @"";
    }
    return _communityId;
}

- (NSString *)nickname {
    if ((NSNull *)_nickname == [NSNull null]) {
        return @"";
    }
    return _nickname;
}

- (BOOL)isMale {
    return (_gender == 1) ? true : false;
}

- (NSString *)birthday {
    if ((NSNull *)_birthday == [NSNull null] || _birthday == nil || [_birthday isEqual:@""]) {
        return @"";
    }
 
//    return _birthday;
    
    // 包含-
    NSRange range = [_birthday rangeOfString:@"-"];
    if (range.length != 0) {
        return _birthday;
    }
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";
    NSDate *birthdayData = [fmt dateFromString:_birthday];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    return [fmt stringFromDate:birthdayData];
}

@end

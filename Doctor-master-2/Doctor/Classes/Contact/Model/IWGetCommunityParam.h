//
//  IWGetCommunityParam.h
//  Doctor
//
//  Created by 范超 on 16/12/17.
//
//

#import <Foundation/Foundation.h>

@interface IWGetCommunityParam : NSObject
/**
 *  登录 ID
 */
@property (nonatomic, copy) NSString *loginId;

/**
 *  公司 ID
 */
@property (nonatomic, copy) NSNumber *companyId;


/**
 *  部门 ID(若为子部门,此项必填)
 */
@property (nonatomic, copy) NSString *communityId;

@property (nonatomic, copy) NSString *type; // 通讯录的是contact ， 社区的是community;
@end

//
//  IWprofileCommunityModel.h
//  Doctor
//
//  Created by 深水区 on 16/12/22.
//
//

#import <Foundation/Foundation.h>

@interface IWprofileCommunityModel : NSObject

/*
 "communityParentId": "",
 "communityName": "游斌权医生专区",
 "communityRemarkName": "游斌权医生专区",
 "communityId": 2261
 
 */

@property (nonatomic, copy) NSString *communityParentId;
@property (nonatomic, copy) NSString *communityName;
@property (nonatomic, copy) NSString *communityRemarkName;
@property (nonatomic, copy) NSString *communityId;




@end

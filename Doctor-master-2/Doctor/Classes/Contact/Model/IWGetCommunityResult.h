//
//  IWGetCommunityResult.h
//  Doctor
//
//  Created by 范超 on 16/12/17.
//
//

#import "IWBaseResult.h"

@interface IWGetCommunityResult : IWBaseResult
@property (nonatomic, strong) NSMutableArray *communityDatas;
@property (nonatomic, strong) NSMutableArray *hospitalDatas;
@end

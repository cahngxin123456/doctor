//
//  IWGetInquiryResult.m
//  Doctor
//
//  Created by 范超 on 2016/12/24.
//
//

#import "IWGetInquiryResult.h"
#import "MJExtension.h"
#import "IWInquiry.h"

@implementation IWGetInquiryResult
- (NSDictionary *)objectClassInArray {
    return @{@"pageData" : [IWInquiry class]};
}
@end

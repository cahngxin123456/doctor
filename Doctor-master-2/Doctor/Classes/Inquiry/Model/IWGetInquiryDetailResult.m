//
//  IWGetInquiryDetailResult.m
//  Doctor
//
//  Created by 范超 on 2016/12/25.
//
//

#import "IWGetInquiryDetailResult.h"
#import "MJExtension.h"
#import "IWGetInquiryDetail.h"


@implementation IWGetInquiryDetailResult
- (NSDictionary *)objectClassInArray {
    return @{@"datas" : [IWGetInquiryDetail class]};
}
@end

//
//  IWInquiryTool.m
//  Doctor
//
//  Created by 范超 on 2016/12/24.
//
//

#import "IWInquiryTool.h"
#import "IWHttpTool.h"
#import "MJExtension.h"

@implementation IWInquiryTool

+ (void)submitDoctorMessageWithParams:(IWAddDoctorMessageParam *)param datas:(NSArray *)datas success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_DO_ASSESS_INQUIRY_DOCTOR_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)inquiryListWithParam:(IWGetInquiryParam *)param success:(void (^)(IWGetInquiryResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_GET_GET_INQUIRY_LIST_URL params:param.keyValues success:^(id json) {
        if (success) {
            IWGetInquiryResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWGetInquiryResult objectWithKeyValues:json[@"datas"]];
            } else {
                result = [[IWGetInquiryResult alloc] init];
                result.code = [json[@"code"] intValue];
                result.info = json[@"info"];
            }
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)submitInquiryWithParams:(IWAddInquiryParam *)param datas:(NSArray *)datas success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool updateImageWithURL:SERVER_SUBMIT_INQUIRY_URL params:param.keyValues datas:datas name:@"uploadImage" success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//+ (void)inquiryDetailWithParam:(IWGetInquiryDetailParam *)param success:(void (^)(NSArray *resultArray))success failure:(void (^)(NSError *error))failure{
//    [IWHttpTool postWithURL:SERVER_GET_INQUIRY_DETAIL_URL params:param.keyValues success:^(id json) {
//        if (success) {
//            IWLog(@"%@", json);
//            NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
//            if ([json[@"code"] intValue] == 0) {
//                for (NSDictionary *subDic in json[@"datas"]) {
//                    IWGetInquiryDetailResult *result = [IWGetInquiryDetailResult objectWithKeyValues:subDic];
//                    [array addObject:result];
//                }
//                
//                
//            } else {
////                result = [[IWGetInquiryDetailResult alloc] init];
////                result.code = [json[@"code"] intValue];
////                result.info = json[@"info"];
//            }
//            success(array);
//        }
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
//}

+ (void)inquiryDetailWithParam:(IWGetInquiryDetailParam *)param success:(void (^)(IWGetInquiryDetailResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_GET_INQUIRY_DETAIL_URL params:param.keyValues success:^(id json) {
        if (success) {
            IWLog(@"%@", json);
            IWGetInquiryDetailResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWGetInquiryDetailResult objectWithKeyValues:json];
            } else {
                result = [[IWGetInquiryDetailResult alloc] init];
                result.code = [json[@"code"] intValue];
                result.info = json[@"info"];
            }
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end

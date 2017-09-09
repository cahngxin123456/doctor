//
//  IWGetInquiryParam.h
//  Doctor
//
//  Created by 范超 on 2016/12/24.
//
//

#import <Foundation/Foundation.h>

typedef enum {
    IWGetInquiryParamTypeMine = 0,
    IWGetInquiryParamTypeFamily,
    IWGetInquiryParamTypeOther,
    IWGetInquiryParamTypeAll
} IWGetInquiryParamType;

typedef enum {
    IWGetInquiryParamStatusSubmit = 0,
    IWGetInquiryParamStatusReply
} IWGetInquiryParamStatus;

@interface IWGetInquiryParam : NSObject

/**
 *  登录 ID
 */
@property (nonatomic, copy) NSString *loginId;

/**
 *  公司 ID
 */
@property (nonatomic, strong) NSNumber *companyId;

@property (nonatomic, assign) IWGetInquiryParamType inquiryType;
@property (nonatomic, assign) IWGetInquiryParamStatus inquiryStatus;


/**
 *  页码
 */
@property (nonatomic, strong) NSNumber *pageNumber;

/**
 *  页面大小
 */
@property (nonatomic, strong) NSNumber *pageSize;

@end

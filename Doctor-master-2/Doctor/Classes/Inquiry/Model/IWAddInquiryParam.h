//
//  IWAddInquiryParam.h
//  Doctor
//
//  Created by 范超 on 2016/12/25.
//
//

#import <Foundation/Foundation.h>

typedef enum {
    IWAddInquiryParamTypeMe = 0,
    IWAddInquiryParamTypeFamily,
    IWAddInquiryParamTypeOther
} IWAddInquiryParamType;


@interface IWAddInquiryParam : NSObject
/**
 *  登录 ID
 */
@property (nonatomic, copy) NSString *loginId;

/**
 *  公司 ID
 */
@property (nonatomic, strong) NSNumber *companyId;


@property (nonatomic, copy) NSString *memberId;
@property (nonatomic, copy) NSString *reportId;
@property (nonatomic, assign) IWAddInquiryParamType inquiryType;
@property (nonatomic, copy) NSString *doctorId;
@property (nonatomic, copy) NSString *doctorName;


/**
 *  描述
 */
@property (nonatomic, copy) NSString *remark;

/**
 *  追问时主留言 ID
 */
@property (nonatomic, copy) NSString *inquiryId;

/**
 *  修改时删除网络图片时
 */
@property (nonatomic, copy) NSString *deletePic;
@end

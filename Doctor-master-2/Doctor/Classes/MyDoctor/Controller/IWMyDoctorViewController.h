//
//  IWMyDoctorViewController.h
//  Doctor
//
//  Created by 范超 on 2017/1/5.
//
//

#import "IWCompanyBaseController.h"

@interface IWMyDoctorViewController : IWCompanyBaseController
@property (nonatomic, assign) BOOL isFromInquiry;
@property (nonatomic, copy) void(^fromeControllerBlock)(NSString *ID,NSString *name);
@end

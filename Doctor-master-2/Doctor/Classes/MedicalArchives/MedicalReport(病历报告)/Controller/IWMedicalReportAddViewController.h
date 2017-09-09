//
//  IWMedicalReportAddViewController.h
//  Doctor
//
//  Created by 范超 on 2016/12/26.
//
//

#import <UIKit/UIKit.h>
#import "IWMedicalReport.h"

@interface IWMedicalReportAddViewController : UIViewController
@property (nonatomic, copy) NSString *memberId;

@property (nonatomic, strong) IWMedicalReport *medicalReportModel;

@property (nonatomic, copy) NSString *reportID;

@end

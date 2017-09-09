//
//  IWMedicalReportViewController.h
//  Doctor
//
//  Created by 深水区 on 16/12/19.
//
//

#import <UIKit/UIKit.h>

@interface IWMedicalReportViewController : UIViewController
@property (nonatomic, copy) NSString *memberId;
@property (nonatomic, assign) BOOL isFromInquiry;
@property (nonatomic, strong) NSMutableArray *reports;

@property (nonatomic, copy) void(^fromeControllerBlock)(NSMutableArray *reports);

@end

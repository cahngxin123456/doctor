//
//  IWDepartmentPeopleViewController.h
//  Doctor
//
//  Created by 范超 on 16/12/17.
//
//

#import "IWContactBaseViewController.h"
#import "IWFanCompany.h"

@interface IWDepartmentPeopleViewController : IWContactBaseViewController
@property (nonatomic, strong) NSArray *departments;
@property (nonatomic, strong) NSArray *peoples;

@property (nonatomic, strong) IWFanCompany *company;
@end

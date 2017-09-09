//
//  IWPeopleViewController.h
//  Doctor
//
//  Created by 范超 on 16/12/17.
//
//

#import "IWContactBaseViewController.h"
@class IWFanCompany;

@interface IWPeopleViewController : IWContactBaseViewController
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) IWFanCompany *company;
@end

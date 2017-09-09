//
//  IWGuoMinViewController.h
//  Doctor
//
//  Created by 深水区 on 16/12/27.
//
//

#import <UIKit/UIKit.h>
#import "IWGuoMin.h"

@interface IWGuoMinViewController : UIViewController

@property (nonatomic, copy) void(^saveButtonBlock)(NSString *s1,NSString *s2,NSString *s3,NSString *s4,NSString *s5,NSString *s6);


@property (nonatomic, strong) IWGuoMin *guominModel;
@property (nonatomic, copy) NSString *memberID;


@end

//
//  IWJiBingViewController.h
//  Doctor
//
//  Created by 深水区 on 16/12/27.
//
//

#import <UIKit/UIKit.h>
#import "IWJiBing.h"

@interface IWJiBingViewController : UIViewController
@property (nonatomic, strong) NSArray *jibingArray;

@property (nonatomic, copy) void(^saveButtonBlock)(NSArray *array);
@property (nonatomic, copy) NSString *memberID;

@end

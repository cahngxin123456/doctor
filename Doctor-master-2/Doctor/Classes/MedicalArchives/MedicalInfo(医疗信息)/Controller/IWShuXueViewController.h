//
//  IWShuXueViewController.h
//  Doctor
//
//  Created by 深水区 on 16/12/27.
//
//

#import <UIKit/UIKit.h>

@interface IWShuXueViewController : UIViewController

@property (nonatomic, strong) NSArray *shuxueArray;

@property (nonatomic, copy) void(^saveButtonBlock)(NSArray *array);
@property (nonatomic, copy) NSString *memberID;
@end

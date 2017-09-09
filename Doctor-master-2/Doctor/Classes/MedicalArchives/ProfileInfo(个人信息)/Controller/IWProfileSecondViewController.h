//
//  IWProfileSecondViewController.h
//  Doctor
//
//  Created by 深水区 on 16/12/19.
//
//

#import <UIKit/UIKit.h>

@interface IWProfileSecondViewController : UIViewController

@property (nonatomic, strong) NSIndexPath *index;

@property (nonatomic, copy) void(^saveButtonBlock)(NSString *item, NSString *numID);

@property (nonatomic, copy) NSString *selectName;
@property (nonatomic, assign) BOOL isFromMine;//从个人中心


@end

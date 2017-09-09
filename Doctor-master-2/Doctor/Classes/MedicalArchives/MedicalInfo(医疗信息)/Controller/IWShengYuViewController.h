//
//  IWShengYuViewController.h
//  Doctor
//
//  Created by 深水区 on 16/12/26.
//
//

#import <UIKit/UIKit.h>

@interface IWShengYuViewController : UIViewController

@property (nonatomic, strong) NSArray *shengyuArray;

@property (nonatomic, copy) NSString *memberID;
@property (nonatomic, copy) void(^saveButtonBlock)(NSArray *array);


@end

//
//  IWJiaZuViewController.h
//  Doctor
//
//  Created by 深水区 on 16/12/27.
//
//

#import <UIKit/UIKit.h>

@interface IWJiaZuViewController : UIViewController

//@property (nonatomic, copy) NSString *typeStr;
@property (nonatomic, strong) NSArray *jiazuArray;

@property (nonatomic, copy) void(^saveButtonBlock)(NSArray *array);
@property (nonatomic, copy) NSString *memberID;

@property (nonatomic, copy) NSString *memberType;


@end

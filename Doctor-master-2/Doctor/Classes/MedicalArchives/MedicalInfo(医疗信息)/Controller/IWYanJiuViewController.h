//
//  IWYanJiuViewController.h
//  Doctor
//
//  Created by 深水区 on 16/12/26.
//
//

#import <UIKit/UIKit.h>
#import "IWYanJiu.h"

@interface IWYanJiuViewController : UIViewController

@property (nonatomic, strong) IWYanJiu *yanjiuModel;
@property (nonatomic, copy) NSString *memberID;

@property (nonatomic, copy) void(^saveButtonBlock)(NSString *str1,NSString *str2,NSString *str3,NSString *str4,NSString *str5);


@end

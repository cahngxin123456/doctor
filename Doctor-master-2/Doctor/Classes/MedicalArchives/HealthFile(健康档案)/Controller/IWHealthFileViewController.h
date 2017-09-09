//
//  IWHealthFileViewController.h
//  Doctor
//
//  Created by 深水区 on 16/12/18.
//
//

#import <UIKit/UIKit.h>

@interface IWHealthFileViewController : UIViewController

@property (nonatomic, copy) NSString *fromeController;
@property (nonatomic, copy) void(^fromeControllerBlock)(NSString *memberID,NSString *name);


@end

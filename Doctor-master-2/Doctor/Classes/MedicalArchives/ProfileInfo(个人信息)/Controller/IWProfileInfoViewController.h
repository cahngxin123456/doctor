//
//  IWProfileInfoViewController.h
//  Doctor
//
//  Created by 深水区 on 16/12/19.
//
//

#import <UIKit/UIKit.h>
#import "IWHealhFileModel.h"


@interface IWProfileInfoViewController : UIViewController

@property (nonatomic, copy) NSString *modelId;
@property (nonatomic, assign) BOOL isFromMine; // 从个人中心进来
@property (nonatomic, copy) NSString *relationship;



@end

//
//  IWProfileSFViewController.h
//  Doctor
//
//  Created by 深水区 on 16/12/22.
//
//

#import <UIKit/UIKit.h>
#import "IWprofileProvinceModel.h"

@interface IWProfileSFViewController : UIViewController

@property (nonatomic, strong) NSIndexPath *index;
@property (nonatomic, assign) BOOL isFromMine;

//社区
@property (nonatomic, copy) NSString *communityID;
//@property (nonatomic,copy) void(^communityBlock)(NSString *item,NSString *strid);


//所属区域
//@property (nonatomic, strong) IWprofileProvinceModel *provinceModel;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *parentCode;

@end

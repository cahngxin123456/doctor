//
//  IWAddDataViewController.h
//  Doctor
//
//  Created by 深水区 on 16/12/25.
//
//

#import <UIKit/UIKit.h>
#import "IWBloodPressureModel.h"
#import "IWBloodSugerModel.h"

@interface IWAddDataViewController : UIViewController

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *memberId;
@property (nonatomic, strong) IWBloodPressureModel *pressureModel;
@property (nonatomic, strong) IWBloodSugerModel *sugerModel;

@end

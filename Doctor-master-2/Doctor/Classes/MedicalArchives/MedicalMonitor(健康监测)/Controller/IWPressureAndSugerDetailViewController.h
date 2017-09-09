//
//  IWPressureAndSugerDetailViewController.h
//  Doctor
//
//  Created by 深水区 on 16/12/30.
//
//

#import <UIKit/UIKit.h>
#import "IWBloodPressureModel.h"
#import "IWBloodSugerModel.h"

@interface IWPressureAndSugerDetailViewController : UIViewController

@property (nonatomic, strong) IWBloodPressureModel *pressureModel;
@property (nonatomic, strong) IWBloodSugerModel *sugerModel;

@property (nonatomic) BOOL isShowresurvey;

@end

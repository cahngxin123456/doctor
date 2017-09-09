//
//  IWAddDataWebViewViewController.m
//  Doctor
//
//  Created by 深水区 on 16/12/25.
//
//

#import "IWAddDataWebViewViewController.h"

@interface IWAddDataWebViewViewController ()
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation IWAddDataWebViewViewController

- (void)viewDidLoad {
    self.url = self.dataArray[self.indexPath.row];
    [super viewDidLoad];
}

- (NSArray *)dataArray{
    if (_dataArray == nil) {
        if ([self.type isEqualToString: @"BloodPressure"]) {
            NSArray *array = @[SERVER_BLOODPRESSURE_1_URL,SERVER_BLOODPRESSURE_2_URL,SERVER_BLOODPRESSURE_3_URL,SERVER_BLOODPRESSURE_4_URL];

            _dataArray = array;
            
        }else{
            NSArray *array = @[SERVER_BLOODSUGAR_1_URL,SERVER_BLOODSUGAR_2_URL,SERVER_BLOODSUGAR_3_URL];
            _dataArray = array;
            
            
        }
        
        
    }
    return _dataArray;
}

@end

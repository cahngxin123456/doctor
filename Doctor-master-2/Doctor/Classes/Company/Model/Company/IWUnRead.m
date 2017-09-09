//
//  IWUnRead.m
//  Conedot
//
//  Created by 范超 on 15/1/31.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWUnRead.h"

@implementation IWUnRead

- (int)approvalTotal {
    return self.approvalingNumber + self.approvalCcNumber + self.approvalEndNumber;
}

- (int)manutalTotalNum {
    return self.manualClassUnReadNumber + self.manualProjectUnReadNumber +
    self.manualQuestionUnReadNumber + self.manualTeacherUnReadNumber + self.manualTrainingUnReadNumber;
}

- (int)count {
    return self.newsUnReadNumber + self.noticeUnReadNumber + self.manualUnReadNumber + self.policyUnReadNumber + self.payslipUnReadNumber + self.questionnaireUnReadNumber + self.recruitUnReadNumber + self.approvalTotal + self.voteNumber + self.activityNumber + self.learnTaskNumber;
}

@end

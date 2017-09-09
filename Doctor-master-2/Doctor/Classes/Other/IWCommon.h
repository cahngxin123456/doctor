//
//  IWCommon.h
//  Doctor
//
//  Created by 范超 on 16/12/17.
//
//

#ifndef IWCommon_h
#define IWCommon_h

// 0.URL
#define SERVER_ROOT @"http://familydoctorcn.com:7070/"
#define SERVER_BASE_URL           ([SERVER_ROOT stringByAppendingString:@"V0102/"])
#define SERVER_BASE_URL1           ([SERVER_ROOT stringByAppendingString:@"Common/"])

#define SERVER_VIEW_DETAIL       ([SERVER_BASE_URL stringByAppendingString:@"ViewDetail/viewDetail.html?type=%@&id=%@&companyId=%ld&loginId=%@"])
#define SERVER_GET_HOME_DISPLAY            ([SERVER_BASE_URL stringByAppendingString:@"GetHomeDisplayList/2J.do"])
#define SERVER_GET_VERSION            ([SERVER_BASE_URL stringByAppendingString:@"GetVersion/2J.do"])
#define SERVER_LOGIN_URL            ([SERVER_BASE_URL stringByAppendingString:@"DoLogin/2J.do"])
#define SERVER_REGISTER_SC_URL      ([SERVER_BASE_URL stringByAppendingString:@"GetRegisterSc/2J.do"])
#define SERVER_DO_CHECK_REGSITER_SC_URL         ([SERVER_BASE_URL stringByAppendingString:@"DoCheckRegisterSc/2J.do"])
#define SERVER_REGISTER_URL         ([SERVER_BASE_URL stringByAppendingString:@"DoRegister/2J.do"])
#define SERVER_HOME_NEWS_LIST_URL   ([SERVER_BASE_URL stringByAppendingString:@"GetTravorNewsList/2J.do"])
#define SERVER_HOME_NEWS_DETAIL_URL ([SERVER_BASE_URL stringByAppendingString:@"GetTravorNewsDetail/2J.do"])
#define SERVER_RELATE_COMPANY_URL    ([SERVER_BASE_URL stringByAppendingString:@"GetNNPList/2J.do"])
#define SERVER_COMPANY_NEWS_LIST_URL      ([SERVER_BASE_URL stringByAppendingString:@"GetNewsList/2J.do"])
#define SERVER_COMPANY_NEWS_DETAIL_URL    ([SERVER_BASE_URL stringByAppendingString:@"GetNewsDetail/2J.do"])
#define SERVER_COMPANY_NOTICE_LIST_URL    ([SERVER_BASE_URL stringByAppendingString:@"GetNoticeList/2J.do"])
#define SERVER_COMPANY_NOTICE_DETAIL_URL  ([SERVER_BASE_URL stringByAppendingString:@"GetNoticeDetail/2J.do"])
#define SERVER_COMPANY_POLICY_LIST_URL    ([SERVER_BASE_URL stringByAppendingString:@"GetPolicyList/2J.do"])
#define SERVER_COMPANY_VOTE_LIST_URL    ([SERVER_BASE_URL stringByAppendingString:@"GetVoteList/2J.do"])
#define SERVER_COMPANY_POLICY_DETAIL_URL  ([SERVER_BASE_URL stringByAppendingString:@"GetPolicyDetail/2J.do"])
#define SERVER_FANS_URL                   ([SERVER_BASE_URL stringByAppendingString:@"GetFans/2J.do"])
#define SERVER_CHANGE_FANS_URL     ([SERVER_BASE_URL stringByAppendingString:@"DoChangeFan/2J.do"])
#define SERVER_COMPANY_FEEDBACK_LIST_URL   ([SERVER_BASE_URL stringByAppendingString:@"GetFeedbackList/2J.do"])
#define SERVER_COMPANY_FEEDBACK_DETAIL_URL ([SERVER_BASE_URL stringByAppendingString:@"GetFeedbackDetail/2J.do"])
#define SERVER_COMPANY_FEEDBACK_SUBMIT_URL   ([SERVER_BASE_URL stringByAppendingString:@"SubmitFeedback/2J.do"])
#define SERVER_COMPANY_QUESTION_LIST_URL   ([SERVER_BASE_URL stringByAppendingString:@"GetQuestionnaireList/2J.do"])
#define SERVER_COMPANY_QUESTION_DETAIL_URL   ([SERVER_BASE_URL stringByAppendingString:@"GetQuestionnaireDetail/view.html"])
#define SERVER_CHANGE_PASSWORD_URL    ([SERVER_BASE_URL stringByAppendingString:@"DoChangePwd/2J.do"])
#define SERVER_FIND_PASSWORD_EMAIL_URL ([SERVER_BASE_URL stringByAppendingString:@"DoResetPwdByMail/2J.do"])
#define SERVER_FIND_PASSWORD_ANSWER_URL ([SERVER_BASE_URL stringByAppendingString:@"DoResetPwdBySQ/2J.do"])
#define SERVER_GET_PASSWORD_SC_URL ([SERVER_BASE_URL stringByAppendingString:@"GetResetPwdSc/2J.do"])
#define SERVER_GET_RESET_PASSWORD_SC_URL ([SERVER_BASE_URL stringByAppendingString:@"GetResetCellphoneSc/2J.do"])
#define SERVER_FIND_PASSWORD_CELLPHONE_URL ([SERVER_BASE_URL stringByAppendingString:@"DoResetPwd/2J.do"])
#define SERVER_CHANGE_USER_URL ([SERVER_BASE_URL stringByAppendingString:@"DoChangeInfo/2J.do"])
#define SERVER_CONTACT_URL ([SERVER_BASE_URL stringByAppendingString:@"GetContact/2J.do"])
#define SERVER_CHANGE_CELLPHONE_URL ([SERVER_BASE_URL stringByAppendingString:@"DoResetCellphone/2J.do"])
#define SERVER_TRAVOR_NEWS_PHOTO_URL ([SERVER_BASE_URL stringByAppendingString:@"GetTravorNewsPhoto/2J.do"])
#define SERVER_PERSON_INFO_URL ([SERVER_BASE_URL stringByAppendingString:@"GetInfo/2J.do"])
#define SERVER_NOTICE_APPLY_URL ([SERVER_BASE_URL stringByAppendingString:@"DoNoticeJoin/2J.do"])
#define SERVER_NEWS_KNOWN_URL ([SERVER_BASE_URL stringByAppendingString:@"DoNewsKnown/2J.do"])
#define SERVER_NOTICE_KNOWN_URL ([SERVER_BASE_URL stringByAppendingString:@"DoNoticeKnown/2J.do"])
#define SERVER_POLICY_KNOWN_URL    ([SERVER_BASE_URL stringByAppendingString:@"DoPolicyKnown/2J.do"])

#define SERVER_NEWS_SIGNUP_URL ([SERVER_BASE_URL stringByAppendingString:@"DoNewsPraize/2J.do"])
#define SERVER_NOTICE_SIGNUP_URL ([SERVER_BASE_URL stringByAppendingString:@"DoNoticePraize/2J.do"])
#define SERVER_POLICY_SIGNUP_URL ([SERVER_BASE_URL stringByAppendingString:@"DoPolicyPraize/2J.do"])
#define SERVER_NEWS_COMMENT_URL ([SERVER_BASE_URL stringByAppendingString:@"DoNewsReview/2J.do"])
#define SERVER_NOTICE_COMMENT_URL ([SERVER_BASE_URL stringByAppendingString:@"DoNoticeReview/2J.do"])
#define SERVER_POLICY_COMMENT_URL ([SERVER_BASE_URL stringByAppendingString:@"DoPolicyReview/2J.do"])
#define SERVER_ME_NOTIFICATION_LIST_URL ([SERVER_BASE_URL stringByAppendingString:@"GetNotificationList/2J.do"])
#define SERVER_ME_NOTIFICATION_KNOWN_URL ([SERVER_BASE_URL stringByAppendingString:@"DoNotificationKnown/2J.do"])

#define SERVER_GET_ADDRESS_URL @"http://familydoctorcn.com:7070/Common/GetRegion/2J.do"

#define SERVER_GET_COMMON_CONTACT_URL ([SERVER_BASE_URL stringByAppendingString:@"GetCommonContact/2J.do"])
#define SERVER_GET_CONTACT_WITH_LEVEL_URL ([SERVER_BASE_URL stringByAppendingString:@"GetContactWithLevel/2J.do"])

// Trainning
#define SERVER_GET_TRAINNING_SYSTEM_LIST_URL ([SERVER_BASE_URL stringByAppendingString:@"GetManualList/2J.do"])
#define SERVER_GET_TRAINNING_SYSTEM_DETAIL_URL ([SERVER_BASE_URL stringByAppendingString:@"GetManualDetail/2J.do"])
#define SERVER_GET_TRAINNING_SYSTEM_DETAIL_KNOWN_URL ([SERVER_BASE_URL stringByAppendingString:@"DoManualKnown/2J.do"])
#define SERVER_GET_TRAINNING_SYSTEM_DETAIL_PRAIZE_URL ([SERVER_BASE_URL stringByAppendingString:@"DoManualPraize/2J.do"])
#define SERVER_GET_TRAINNING_SYSTEM_DETAIL_REVIEW_URL ([SERVER_BASE_URL stringByAppendingString:@"DoManualReview/2J.do"])

// Help Feedback
#define SERVER_GET_TRAVOR_FEEDBACK_LIST_URL ([SERVER_BASE_URL stringByAppendingString:@"GetTravorFeedbackList/2J.do"])
#define SERVER_GET_TRAVOR_FEEDBACK_DETAIL_URL ([SERVER_BASE_URL stringByAppendingString:@"GetTravorFeedbackDetail/2J.do"])
#define SERVER_SUBMIT_TRAVOR_FEEDBACK_URL ([SERVER_BASE_URL stringByAppendingString:@"SubmitTravorFeedback/2J.do"])

// Unread Message
#define SERVER_GET_ALL_UNREAD_NUMBER_URL ([SERVER_BASE_URL stringByAppendingString:@"GetAllUnReadNumber/2J.do"])
#define SERVER_GET_REMIND_NUMBER_URL ([SERVER_BASE_URL stringByAppendingString:@"GetRemindNumber/2J.do"])

#define SERVER_SUBMIT_SIGN_URL ([SERVER_BASE_URL stringByAppendingString:@"SubmitSign/2J.do"])
#define SERVER_GET_SIGN_LIST_URL ([SERVER_BASE_URL stringByAppendingString:@"GetSignList/2J.do"])
#define SERVER_GET_COMMON_CONTACT_URL ([SERVER_BASE_URL stringByAppendingString:@"GetCommonContact/2J.do"])
#define SERVER_GET_SHARE_LIST_URL ([SERVER_BASE_URL stringByAppendingString:@"GetShareList/2J.do"])
#define SERVER_SUBMIT_SHARE_URL ([SERVER_BASE_URL stringByAppendingString:@"SubmitShare/2J.do"])
#define SERVER_GET_SHARE_DETAIL_URL ([SERVER_BASE_URL stringByAppendingString:@"GetShareDetail/2J.do"])
#define SERVER_GET_PUBLISHED_SHARE_LIST_URL ([SERVER_BASE_URL stringByAppendingString:@"GetPublishedShareList/2J.do"])
#define SERVER_DO_SHUTDOWN_SHARE_URL ([SERVER_BASE_URL stringByAppendingString:@"DoShutDownShare/2J.do"])
#define SERVER_COMPANY_MOVEMENT_LIST_URL ([SERVER_BASE_URL stringByAppendingString:@"GetActivityList/2J.do"])
#define SERVER_DO_ACTIVITY_KEY_READ_URL ([SERVER_BASE_URL stringByAppendingString:@"DoActivityKeyRead/2J.do"])
#define SERVER_GET_ACTIVITY_DETAIL_URL ([SERVER_BASE_URL stringByAppendingString:@"GetActivityDetail/2J.do"])
#define SERVER_DO_ACTIVITY_JOIN_URL ([SERVER_BASE_URL stringByAppendingString:@"DoActivityJoin/2J.do"])
#define SERVER_DO_ACTIVITY_KNOWN_URL ([SERVER_BASE_URL stringByAppendingString:@"DoActivityKnown/2J.do"])
#define SERVER_DO_ACTIVITY_PRAIZE_URL ([SERVER_BASE_URL stringByAppendingString:@"DoActivityPraize/2J.do"])
#define SERVER_DO_ACTIVITY_REVIEW_URL ([SERVER_BASE_URL stringByAppendingString:@"DoActivityReview/2J.do"])
#define SERVER_GET_LEARN_TASK_LIST_URL ([SERVER_BASE_URL stringByAppendingString:@"GetLearnTaskList/2J.do"])
#define SERVER_GET_LEARN_TASK_DETAIL_URL ([SERVER_BASE_URL stringByAppendingString:@"GetLearnTaskDetail/2J.do"])
#define SERVER_DO_LEARN_TASK_LEARNED_URL ([SERVER_BASE_URL stringByAppendingString:@"DoLearnTaskLearned/2J.do"])
#define SERVER_GET_REPORT_LIST_URL ([SERVER_BASE_URL stringByAppendingString:@"GetReportList/2J.do"])
#define SERVER_GET_REPORTED_LIST_URL ([SERVER_BASE_URL stringByAppendingString:@"GetReportedList/2J.do"])
#define SERVER_GET_REPORT_DETAIL_URL ([SERVER_BASE_URL stringByAppendingString:@"GetReportDetail/view.html?id=%@&userId=%@&type=%@"])
#define SERVER_GET_APPROVAL_COPY_LIST_URL ([SERVER_BASE_URL stringByAppendingString:@"GetCcList/2J.do"])

#define SERVER_GET_TRAIN_CLASS_LIST_URL ([SERVER_BASE_URL stringByAppendingString:@"GetTrainClassList/2J.do"])
#define SERVER_JOIN_OR_REFUSE_TRAIN_CLASS_URL ([SERVER_BASE_URL stringByAppendingString:@"JoinOrRefuseTrainClass/2J.do"])
#define SERVER_GET_TRAINNING_COURSE_DETAIL_URL ([SERVER_BASE_URL stringByAppendingString:@"TrainClass/viewClass.html?id=%@&companyId=%@&loginId=%@"])
#define SERVER_GET_AGREE_ILLUSTRATION_URL ([SERVER_ROOT stringByAppendingString:@"/agree/illustration.html"])
#define SERVER_GET_VIEW_DOCTORINFO_URL ([SERVER_BASE_URL stringByAppendingString:@"ViewDoctorInfo/viewDoctorInfo.html?loginId=%@"])

#define SERVER_GET_VIEW_AGREEMENT_URL ([SERVER_BASE_URL stringByAppendingString:@"ViewAgreement/viewAgreement.html?loginId=%@"])
#define SERVER_GET_GET_INQUIRY_LIST_URL ([SERVER_BASE_URL stringByAppendingString:@"GetInquiryList/2J.do"])
#define SERVER_GET_GET_INQUIRY_MEMBER_LIST_URL ([SERVER_BASE_URL stringByAppendingString:@"GetInquiryMemberList/2J.do"])
#define SERVER_DO_DELETE_INQUIRY_MEMBER_URL ([SERVER_BASE_URL stringByAppendingString:@"DoDeleteInquiryMember/2J.do"])
#define SERVER_SUBMIT_INQUIRY_URL ([SERVER_BASE_URL stringByAppendingString:@"SubmitInquiry/2J.do"])
#define SERVER_DO_EDIT_INQUIRY_MEMBER_URL ([SERVER_BASE_URL stringByAppendingString:@"DoEditInquiryMember/2J.do"])
#define SERVER_GET_INQUIRY_DETAIL_URL ([SERVER_BASE_URL stringByAppendingString:@"GetInquiryDetail/2J.do"])
#define SERVER_GET_INQUIRY_MEMBER_DETAIL_URL ([SERVER_BASE_URL stringByAppendingString:@"GetInquiryMemberDetail/2J.do"])
#define SERVER_GET_COMMUNITY_HOSPITAL_URL ([SERVER_BASE_URL stringByAppendingString:@"GetCommunityHospital/2J.do"])
#define SERVER_GET_HOSPITAL_CONTACT_URL ([SERVER_BASE_URL stringByAppendingString:@"GetHospitalContact/2J.do"])
#define SERVER_GET_MEDICAL_INFO_URL ([SERVER_BASE_URL stringByAppendingString:@"health/my/myMedicalInfo.html?loginId=%1%@"])
#define SERVER_GET_LOGIN_INFO_URL ([SERVER_BASE_URL stringByAppendingString:@"GetLoginInfo/2J.do"])
#define SERVER_GET_GET_MEMBER_LIST_URL ([SERVER_BASE_URL stringByAppendingString:@"GetMemberList/2J.do"])
#define SERVER_SUBMIT_DISEASE_REPORT_URL ([SERVER_BASE_URL stringByAppendingString:@"SubmitDiseaseReport/2J.do"])

#define SERVER_GET_DISEASE_REPORT_LIST_URL ([SERVER_BASE_URL stringByAppendingString:@"GetDiseaseReportList/2J.do"])
#define SERVER_DO_DELETE_DISEASE_REPORT_URL ([SERVER_BASE_URL stringByAppendingString:@"DoDeleteDiseaseReport/2J.do"])
#define SERVER_GET_DISEASE_REPORT_DETAIL_URL ([SERVER_BASE_URL stringByAppendingString:@"GetDiseaseReportDetail/2J.do"])
#define SERVER_GET_BLOOD_PRESSURE_LIST_URL ([SERVER_BASE_URL stringByAppendingString:@"GetBloodPressureList/2J.do"])
#define SERVER_GET_BLOOD_SUGAR_LIST_URL ([SERVER_BASE_URL stringByAppendingString:@"GetBloodSugarList/2J.do"])
#define SERVER_SUBMIT_BLOODPRESSURE_URL ([SERVER_BASE_URL stringByAppendingString:@"SubmitBloodPressure/2J.do"])
#define SERVER_SUBMIT_BLOODSUGAR_URL ([SERVER_BASE_URL stringByAppendingString:@"SubmitBloodSugar/2J.do"])
#define SERVER_DO_DELETE_BLOOD_PRESSURE_URL ([SERVER_BASE_URL stringByAppendingString:@"DoDeleteBloodPressure/2J.do"])
#define SERVER_DO_DELETE_BLOOD_SUGAR_URL ([SERVER_BASE_URL stringByAppendingString:@"DoDeleteBloodSugar/2J.do"])
#define SERVER_GET_BLOOD_PRESSURE_DETAIL_URL ([SERVER_BASE_URL stringByAppendingString:@"GetBloodPressureDetail/2J.do"])
#define SERVER_GET_LASTED_BLOOD_PRESSURE_URL ([SERVER_BASE_URL stringByAppendingString:@"GetLastedBloodPressure/2J.do"])
#define SERVER_GET_BLOOD_SUGAR_DETAIL_URL ([SERVER_BASE_URL stringByAppendingString:@"GetBloodSugarDetail/2J.do"])
#define SERVER_GET_LASTED_BLOOD_SUGAR_URL ([SERVER_BASE_URL stringByAppendingString:@"GetLastedBloodSugar/2J.do"])
#define SERVER_DO_SUBMIT_MEMBER_INFO_URL ([SERVER_BASE_URL stringByAppendingString:@"DoSubmitMemberInfo/2J.do"])
#define SERVER_DO_DELETE_MEMBER_URL ([SERVER_BASE_URL stringByAppendingString:@"DoDeleteMember/2J.do"])
#define SERVER_DO_ASSESS_INQUIRY_DOCTOR_URL ([SERVER_BASE_URL stringByAppendingString:@"DoAssessInquiryDoctor/2J.do"])

#define SERVER_DO_CHANGE_INFO_URL ([SERVER_BASE_URL stringByAppendingString:@"DoChangeInfo/2J.do"])

#define SERVER_GET_TRAVOR_GETNNPLIST_URL ([SERVER_BASE_URL stringByAppendingString:@"GetNNPList/2J.do"])
#define SERVER_GET_MY_DOCTORLIST_URL ([SERVER_BASE_URL stringByAppendingString:@"GetMyDoctorList/2J.do"])
#define SERVER_GET_VIEW_SPECIAL_DOCTORINFO_URL ([SERVER_BASE_URL stringByAppendingString:@"ViewSpecialDoctorInfo/viewSpecialDoctorInfo.html?doctorId=%@&loginId=%@"])
#define SERVER_GET_VIEW_SPECIAL_DOCTORINFO_SHARE_URL ([SERVER_BASE_URL stringByAppendingString:@"ViewSpecialDoctorInfo/viewSpecialDoctorInfo.html?doctorId=%@"])

#define SERVER_BLOODPRESSURE_1_URL ([SERVER_ROOT stringByAppendingString:@"/bloodpressure/illustration1.html"])
#define SERVER_BLOODPRESSURE_2_URL ([SERVER_ROOT stringByAppendingString:@"/bloodpressure/illustration2.html"])
#define SERVER_BLOODPRESSURE_3_URL ([SERVER_ROOT stringByAppendingString:@"/bloodpressure/illustration3.html"])
#define SERVER_BLOODPRESSURE_4_URL ([SERVER_ROOT stringByAppendingString:@"/bloodpressure/illustration4.html"])
#define SERVER_BLOODSUGAR_1_URL ([SERVER_ROOT stringByAppendingString:@"/bloodsugar/illustration1.html"])
#define SERVER_BLOODSUGAR_2_URL ([SERVER_ROOT stringByAppendingString:@"/bloodsugar/illustration2.html"])
#define SERVER_BLOODSUGAR_3_URL ([SERVER_ROOT stringByAppendingString:@"/bloodsugar/illustration3.html"])


#define SERVER_HEALTH_GET_URL ([SERVER_BASE_URL stringByAppendingString:@"health/my/mainGet.do"])
#define SERVER_HEALTH_HEIGHT_URL ([SERVER_BASE_URL stringByAppendingString:@"health/my/heightSave.do"])
#define SERVER_HEALTH_WEIGHT_URL ([SERVER_BASE_URL stringByAppendingString:@"health/my/weightSave.do"])
#define SERVER_HEALTH_BLOOD_URL ([SERVER_BASE_URL stringByAppendingString:@"health/my/bloodTypeSave.do"])
#define SERVER_HEALTH_SHENGYU_URL ([SERVER_BASE_URL stringByAppendingString:@"health/my/shengyuBtnSave.do"])
#define SERVER_HEALTH_YANJIU_URL ([SERVER_BASE_URL stringByAppendingString:@"health/my/yanjiuBtnSave.do"])
#define SERVER_HEALTH_GUOMIN_URL ([SERVER_BASE_URL stringByAppendingString:@"health/my/guominBtnSave.do"])
#define SERVER_HEALTH_BAOLU_URL ([SERVER_BASE_URL stringByAppendingString:@"health/my/baoluBtnSave.do"])
#define SERVER_HEALTH_JIBING_URL ([SERVER_BASE_URL stringByAppendingString:@"health/my/jibingBtnSave.do"])
#define SERVER_HEALTH_SHOUSHU_URL ([SERVER_BASE_URL stringByAppendingString:@"health/my/shoushuBtnSave.do"])
#define SERVER_HEALTH_SHUXUE_URL ([SERVER_BASE_URL stringByAppendingString:@"health/my/shuxueBtnSave.do"])
#define SERVER_HEALTH_JIAZU_URL ([SERVER_BASE_URL stringByAppendingString:@"health/my/jiazuBtnSave.do"])
#define SERVER_HEALTH_YICHUAN_URL ([SERVER_BASE_URL stringByAppendingString:@"health/my/yichuanBtnSave.do"])
#define SERVER_HEALTH_CANJI_URL ([SERVER_BASE_URL stringByAppendingString:@"health/my/canjiBtnSave.do"])
#define SERVER_HEALTH_DUANLIAN_URL ([SERVER_BASE_URL stringByAppendingString:@"health/my/exerciseSave.do"])

// Number
#define IWPAGESIZE 10
#define IWTIMECOUNT 59

#define DEFUALT_MARGIN_SIDES 12
#define kHeight [[UIScreen mainScreen] bounds].size.height
#define kWidth  [[UIScreen mainScreen] bounds].size.width

// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 2.Color
#define IWMainBgColor IWColor(236, 236, 237)
#define IWTableViewBgColor IWColor(238, 240, 246)
#define IWGlobalColor IWColor(4, 186, 164)
#define IWLoadingColor IWColor(4, 186, 164)
#define IWBlueColor IWColor(22,154,255)
#define IWGreenColor IWColor(32,157,3)
#define IWColor(r, g, b) IWColorWithAlpha(r, g, b, 1)
#define IWColorWithAlpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define IWColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// Background
#define IWLoginBg [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg"]]
#define IWGlobalBg [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]


// 3.自定义Log
#ifdef DEBUG
#define IWLog(...) NSLog(__VA_ARGS__)
#else
#define IWLog(...)
#endif

// 4.是否为4inch
#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)

// 5.Conedot的属性


// 6.常用的对象
#define IWNotificationCenter [NSNotificationCenter defaultCenter]
#define IWUserDefaults [NSUserDefaults standardUserDefaults]

// 7.常量
#define IWTableBorderW  6
#define IWCellMargin  6
#define IWCompanyId 101915
#define IWAppID @"903699222"
#define UMENG_APPKEY @"586e2960cae7e74e54001125"
#define IWQQAppID @"1101475104"
#define IWQQAppSecret @"tr0Hxq86fPOf4oYP"
#define IWWeiXinAppID @"wxc580418c035487e7"
#define IWWeiXinAppSecret @"3348c14132299398791b00d913b49bc3"
#define IWAmapKey @"758bb44a3ed7a8105965382909bd05e8"

#define kGtAppId           @"MwlyEJUxej6qAULN26v9M8"
#define kGtAppKey          @"QuxAE6ymoB8xl9vaDYMV68"
#define kGtAppSecret       @"v4wwA5axrF694IyjDC2zl7"

// 8.UserDefault
#define UserDefaultCompanyId @"companyId"
#define UserDefaultContactHeaderTitle @"UserDefaultContactHeaderTitle"
#define UserDefaultContactApprovalUserId @"UserDefaultContactApprovalUserId"
#define UserDefaultContactApprovalUserName @"UserDefaultContactApprovalUserName"
#define UserDefaultContactApprovalHidden @"UserDefaultContactApprovalHidden"
#define UserDefaultSignTime @"UserDefaultSignTime"

// 9.尺寸
#define IWWIDTH   [UIScreen mainScreen].bounds.size.width
#define IWHEIGHT  [UIScreen mainScreen].bounds.size.height
#define IWValue(value) ((value)/750.0f*[UIScreen mainScreen].bounds.size.width)

//10.控件属性
#define IWFont [UIFont systemFontOfSize:12]

//缩放系数
#define SFXISHU 0.7


// 招聘详情中的字体
#define IWRecruitDetailTitleFont [UIFont systemFontOfSize:15]
#define IWRecruitDetailOtherFont [UIFont systemFontOfSize:14]
#define IWRecruitDetailButtonFont [UIFont systemFontOfSize:16]

// 我的问详情中的字体
#define IWMyQuestionDetailTitleFont [UIFont systemFontOfSize:15]
#define IWMyQuestionDetailOtherFont [UIFont systemFontOfSize:14]

// 通知
// 推送的通知
#define IWRemotionNotification @"IWRemotionNotification"
#define IWRemotionActiveNotification @"IWRemotionActiveNotification"
#define IWRemotionPushNotification @"IWRemotionPushNotification"
#define IWRemotionPushCompany @"IWRemotionPushCompany"

#define IWLoadUserUINotification @"IWLoadUserUINotification"

// 图片删除通知
#define IWImagesDeleteNotification @"IWImagesDeleteNotification"
#define IWImagesDeleteNotificationPic @"IWImagesDeleteNotificationPic"

// 图片点击的通知
#define IWHomeClickNotification @"IWHomeClickNotification"

// 图片点击的通知
#define IWHomeClickNotification @"IWHomeClickNotification"
#define IWHomeClickNotificationBanner @"IWHomeClickNotificationBanner"

#endif

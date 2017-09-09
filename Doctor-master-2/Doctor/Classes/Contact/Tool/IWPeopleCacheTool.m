//
//  IWPeopleCacheTool.m
//  Conedot
//
//  Created by 范超 on 15/3/9.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWPeopleCacheTool.h"
#import "IWPeople.h"
#import "IWUserTool.h"
#import "IWUser.h"
#import "FMDB.h"

@implementation IWPeopleCacheTool

static FMDatabaseQueue *_queue;

+ (void)setup {
    // 0.获得沙盒中的数据库文件名
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"people.sqlite"];
    
    // 1.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 2.创表
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_people (id INTEGER PRIMARY KEY AUTOINCREMENT, people BLOB, loginId TEXT, userId TEXT, insertTime INTEGER);"];
    }];
}

+ (void)addPeople:(IWPeople *)people {
    [self setup];
    
    [_queue inDatabase:^(FMDatabase *db) {
        // 1.获得需要存储的数据
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:people];
        NSString *loginId = [IWUserTool user].loginId;
        long currentTime = (long)[[NSDate date] timeIntervalSince1970];
        NSString *nowString = [NSString stringWithFormat:@"%ld", currentTime];
        
        // 2.查询本地是否存在
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_people WHERE loginId = ? AND userId = ?", loginId, people.userId];
        if (rs.next) {
            // 修改
            [db executeUpdate:@"UPDATE t_people SET insertTime = ? WHERE loginId = ? AND userId = ?", nowString, [rs stringForColumn:@"loginId"], [rs stringForColumn:@"userId"]];
        } else {
            // 插入
            [db executeUpdate:@"INSERT INTO t_people (people, loginId, userId, insertTime) VALUES (?, ?, ?, ?)", data, loginId, people.userId, nowString];
        }
        
        [rs close];
    }];
    
    [_queue close];
}

+ (void)deletePeople:(IWPeople *)people {
    [self setup];
    
    [_queue inDatabase:^(FMDatabase *db) {
        
        // loginId
        NSString *loginId = [IWUserTool user].loginId;
        
        [db executeUpdate:@"DELETE FROM t_people WHERE loginId = ? AND userId = ?", loginId, people.userId];
        
    }];
    
    [_queue close];
}

+ (NSMutableArray *)peoples {
    [self setup];
    
    // 1.定义数组
    __block NSMutableArray *peopleArray = nil;
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        peopleArray = [NSMutableArray array];
        
        // loginId
        NSString *loginId = [IWUserTool user].loginId;
        
        // 查询
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_people WHERE loginId = ? ORDER BY insertTime DESC LIMIT 10", loginId];
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"people"];
            IWPeople *people = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [peopleArray addObject:people];
        }
    }];
    
    [_queue close];
    
    return peopleArray;
}

@end

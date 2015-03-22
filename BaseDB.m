//
//  BaseDB.m
//  Userdemo
//
//  Created by mhand on 14/11/24.
//  Copyright (c) 2014年 mhand. All rights reserved.
//
//数据库基本操作类
#import "BaseDB.h"
#import <sqlite3.h>
#define kFilename @"data.sqlite"
@implementation BaseDB
//创建表
-(NSString *)filePath{
    NSString *filepath=[NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",kFilename];
    NSLog(@"%@",filepath);
    return filepath;
}

-(void)creatTable:(NSString *)sql{
//    打开数据库
    sqlite3 *sqlite=nil;
    const char *filename=[self.filePath UTF8String];
  int result=  sqlite3_open(filename, &sqlite);
    if (result!=SQLITE_OK) {
        NSLog(@"打开数据库失败");
        
        sqlite3_close(sqlite);
        return;

    }
//    执行创建表的sql语句
    char *errormesg=nil;
  result=  sqlite3_exec(sqlite, [sql UTF8String], nil, nil,&errormesg );
    if (result!=SQLITE_OK) {
        NSLog(@"创建表失败");
        sqlite3_close(sqlite);

    }
    sqlite3_close(sqlite);

    
}
//INSERT INTO User(username,password,email)values(?,?,?)
-(BOOL)dealData:(NSString *)sql paramsarray:(NSArray *)params
{
    //    打开数据库
    sqlite3 *sqlite=nil;
    sqlite3_stmt *stmt=nil;
    const char *filename=[self.filePath UTF8String];
    int result=  sqlite3_open(filename, &sqlite);
    if (result!=SQLITE_OK) {
        NSLog(@"打开数据库失败");
        
        sqlite3_close(sqlite);
        return NO;
        
    }
//    编译sql语句
  result=  sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &stmt, nil);
    if (result!=SQLITE_OK) {
        NSLog(@"sql语句编译失败");
        sqlite3_close(sqlite);
        return NO;
    }
//    绑定数据
    for (int i=0; i<[params count]; i++) {
        NSString *value=[params objectAtIndex:i];
//        索引值从1开始
        sqlite3_bind_text(stmt, i+1, [value UTF8String], -1, nil);

    }
//    执行sql语句
    result=sqlite3_step(stmt);
    if (result==SQLITE_ERROR) {
        NSLog(@"sql语句 执行失败");
        sqlite3_close(sqlite);
        return NO;
    }

    sqlite3_clear_bindings(stmt);
    sqlite3_close(sqlite);
    
    return YES;
    
    
    
  
    
    
    
    
}
//SELECT username,password,email From User
-(NSMutableArray *)selectData:(NSString *)sql columns:(int)number{
//    NSMutableArray *
    sqlite3 *sqlite=nil;
    sqlite3_stmt *stmt=nil;
    const char *filename=[self.filePath UTF8String];
    int result=  sqlite3_open(filename, &sqlite);
    if (result!=SQLITE_OK) {
        NSLog(@"打开数据库失败");
        
        sqlite3_close(sqlite);
        return nil;
        
    }
    result=  sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &stmt, nil);
    if (result!=SQLITE_OK) {
        NSLog(@"sql语句编译失败");
        sqlite3_close(sqlite);
        return nil;
    }

  result=  sqlite3_step(stmt);
    NSMutableArray *data=[NSMutableArray array];
    while (result==SQLITE_ROW) {
        NSMutableArray *row=[NSMutableArray arrayWithCapacity:number];
        for (int i=0; i<number; i++) {
            
          char *columText=(char *)  sqlite3_column_text(stmt, i);
            NSString *string=[NSString stringWithCString:columText encoding:NSUTF8StringEncoding];
            [row addObject:string];
        }
        
        [data addObject:row];
  
        
        result=sqlite3_step(stmt);
    }
    
    sqlite3_clear_bindings(stmt);
    sqlite3_close(sqlite);

    
    return data;
    
   
}
@end

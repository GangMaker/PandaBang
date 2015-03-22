//
//  BaseDB.h
//  Userdemo
//
//  Created by mhand on 14/11/24.
//  Copyright (c) 2014年 mhand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseDB : NSObject
-(void)creatTable:(NSString *)sql;
-(NSString *)filePath;
/*
 
 接口描述：插入数据 删除数据 修改数据  
 参数：sql：SQL语句
 返回值；是否执行成功
 */
-(BOOL)dealData:(NSString *)sql paramsarray:(NSArray *)params;
/*
 接口描述：查询数据
 参数：sql：SQL语句

返回值 :[["字段值1","字段值2","字段值3"],[],[]]
 */
-(NSMutableArray *)selectData:(NSString *)sql columns:(int)number;

@end

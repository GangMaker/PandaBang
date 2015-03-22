//
//  UserDB.m
//  Userdemo
//
//  Created by mhand on 14/11/24.
//  Copyright (c) 2014年 mhand. All rights reserved.
//

#import "UserDB.h"
#import "UserModal.h"
static UserDB *instnce;
@implementation UserDB
+(id)shareInstance{
    if (instnce==nil) {
        instnce=[[[self class]alloc]init];
    }
    return instnce;

}

-(id)init{
    self=[super init];
    if (self!=nil) {
    
    }
    return self;

}
//创建用户表

-(void)creatTable{
    NSString *sql=@"CREATE TABLE IF NOT EXISTS User (username TEXT primary key,password TEXT,age TEXT)";
    [self creatTable:sql];
    
}
// 添加用户
-(BOOL)addUser:(UserModal *)userModal{
NSString *sql=@"INSERT OR REPLACE INTO User(username,password,age)VALUES(?,?,?)";
    NSArray *params=[NSArray arrayWithObjects:userModal.userName,userModal.password,userModal.age, nil];
   return [self dealData:sql paramsarray:params];
    
}
//删除用户
-(BOOL)deleteUser:(UserModal *)userModal{

    NSString *sql=@"DELETE FROM User WHERE username=?";
    NSArray *params=[NSArray arrayWithObjects:userModal.userName, nil];
    return [self dealData:sql paramsarray:params];

}
//更新用户
-(BOOL)updataUser:(UserModal *)lastuserModal  toUser:(UserModal *)userModal{
    NSString *sql=@"UPDATE User set username=? , password=? , age=? WHERE username=?";
    NSArray *params=[NSArray arrayWithObjects:userModal.userName,userModal.password,userModal.age,lastuserModal.userName, nil];
    

    return [self dealData:sql paramsarray:params];


}
-(NSArray *)findUsers{
NSString *sql=@"SELECT username,password,age FROM User";
    NSMutableArray *users=[NSMutableArray array];
    NSArray *data=  [self selectData:sql columns:3];
    for (NSArray *row in data) {
       NSString *username= [row objectAtIndex:0];
        NSString *password= [row objectAtIndex:1];
        NSString *age= [row objectAtIndex:2];
        UserModal *user=[[UserModal alloc]init];
        user.userName=username;
        user.password=password;
        user.age=age;
        [users addObject:user];

    }
    return users;
}
@end

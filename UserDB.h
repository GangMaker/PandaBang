//
//  UserDB.h
//  Userdemo
//
//  Created by mhand on 14/11/24.
//  Copyright (c) 2014年 mhand. All rights reserved.
//

#import "BaseDB.h"
@class UserModal;
@interface UserDB : BaseDB
-(id)init;
-(BOOL)deleteUser:(UserModal *)userModal;
-(void)creatTable;
-(BOOL)addUser:(UserModal *)userModal;
-(BOOL)updataUser:(UserModal *)lastuserModal  toUser:(UserModal *)userModal;
-(NSArray *)findUsers;
//单利方法
+(id)shareInstance;

@end

//
//  ViewController.m
//  ZPMFMDB
//
//  Created by Liu Zhao on 2018/3/26.
//  Copyright © 2018年 Liu Zhao. All rights reserved.
//

#import "ViewController.h"
#import "JQFMDB.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Person *person = [[Person alloc] init];
    person.name = @"cleanmonkey";
    person.phoneNum = @(18866668888);
    person.photoData = UIImagePNGRepresentation([UIImage imageNamed:@"bg.jpg"]);
    person.luckyNum = 7;
    person.sex = 0;
    person.age = 26;
    person.height = 172.12;
    person.weight = 120.4555;
    
    JQFMDB *db = [JQFMDB shareDatabase];
    NSLog(@"last:%ld", (long)[db lastInsertPrimaryKeyId:@"user"]);
    
    [db jq_createTable:@"user" dicOrModel:person];
    
    //插入一条数据
    [db jq_insertTable:@"user" dicOrModel:person];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

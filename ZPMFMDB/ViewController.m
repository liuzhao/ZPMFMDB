//
//  ViewController.m
//  ZPMFMDB
//
//  Created by Liu Zhao on 2018/3/26.
//  Copyright © 2018年 Liu Zhao. All rights reserved.
//

#import "ViewController.h"
#import "ZPMFMDB.h"
#import "Person.h"

#define TABLE_NAME @"HomeList"

@interface ViewController ()

@property (nonatomic, strong) ZPMFMDB *db;
@property (nonatomic, strong) Person *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initData];
    
    UIButton *insertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [insertBtn setTitle:@"insert" forState:UIControlStateNormal];
    [insertBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [insertBtn setFrame:CGRectMake(100, 100, 100, 30)];
    [insertBtn addTarget:self action:@selector(inserData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:insertBtn];
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setTitle:@"delete" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [deleteBtn setFrame:CGRectMake(100, 150, 100, 30)];
    [deleteBtn addTarget:self action:@selector(deleteData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteBtn];
    
    UIButton *updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [updateBtn setTitle:@"update" forState:UIControlStateNormal];
    [updateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [updateBtn setFrame:CGRectMake(100, 200, 100, 30)];
    [updateBtn addTarget:self action:@selector(updateData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:updateBtn];
    
    UIButton *lookupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lookupBtn setTitle:@"lookup" forState:UIControlStateNormal];
    [lookupBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lookupBtn setFrame:CGRectMake(100, 250, 100, 30)];
    [lookupBtn addTarget:self action:@selector(lookupData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lookupBtn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData
{
    Person *person = [[Person alloc] init];
    person.name = @"liuzhao";
    person.phoneNum = @(18601387064);
    person.photoData = UIImagePNGRepresentation([UIImage imageNamed:@"256.png"]);
    person.luckyNum = 7;
    person.sex = 0;
    person.age = 18;
    person.height = 172.12;
    person.weight = 120.4555;
    self.person = person;
    
    ZPMFMDB *db = [ZPMFMDB shareDatabase:@"ZpmHome.sqlite"];
    self.db = db;
    [db zpm_createTable:TABLE_NAME dicOrModel:[Person class]];
}

- (void)inserData
{
    //插入一条数据
    [_db zpm_insertTable:TABLE_NAME dicOrModel:_person];
    
    NSLog(@"last:%ld", (long)[_db lastInsertPrimaryKeyId:@"HomeList"]);
}

- (void)deleteData
{
    //删除最后一条数据
    [_db zpm_deleteTable:TABLE_NAME whereFormat:@"WHERE pkid = (SELECT min(pkid) FROM HomeList)"];
}

- (void)updateData
{
    [_db zpm_updateTable:TABLE_NAME dicOrModel:@{@"name":@"testName"} whereFormat:@"WHERE pkid = (SELECT max(pkid) FROM HomeList)"];
}

- (void)lookupData
{
    //查找表中所有数据
    NSArray *personArr = [_db zpm_lookupTable:TABLE_NAME dicOrModel:[Person class] whereFormat:nil];
    NSLog(@"表中所有数据:%@", personArr);
}

- (void)lookupDataWithId
{
    //查找表中所有数据
    NSArray *personArr = [_db zpm_lookupTable:TABLE_NAME dicOrModel:[Person class] whereFormat:@"where pkid = '2'"];
    NSLog(@"name=liuzhao:%@", personArr);
}


@end

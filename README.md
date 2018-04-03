# ZPMFMDB
封装好的FMDB，目标是不会SQL也能直接使用。

![Logo](https://github.com/liuzhao/ZPMFMDB/blob/master/Images/256.png "智联logo")

[我的简书](https://www.jianshu.com/u/e83faf720ae7)

## 安装方法

pod 'ZPMFMDB'


* 针对于FMDB的二次封装
* 线程安全
* 支持事务操作(目前others都仅支持线程安全)
* 操作简单, Model和Dictionary直接存储
* 拓展性强
* 不侵入你的任何Model
* 不需要实现某些奇怪的协议

## 使用教程

### 创建数据库
#### 单例方法

如果工程只需要一个数据库，推荐使用单例方式

    + (instancetype)shareDatabase;
    + (instancetype)shareDatabase:(NSString *)dbName;
    + (instancetype)shareDatabase:(NSString *)dbName path:(NSString *)dbPath;
    
#### init方法

如果工程需要多个不同的数据库，推荐使用init方法

    - (instancetype)initWithDBName:(NSString *)dbName;
    - (instancetype)initWithDBName:(NSString *)dbName path:(NSString *)dbPath;


### 创建一个数据库和表
```
  // LIST_NAME:你的表名  [Person class]：你自定义的model类
  ZPMFMDB *db = [ZPMFMDB shareDatabase:@"ZpmHome.sqlite"];
  [db zpm_createTable:TABLE_NAME dicOrModel:[Person class]];
```

### 增加
#### 插入一条数据
```
  // person:你的实例化的model类
  [_db zpm_insertTable:TABLE_NAME dicOrModel:person];
  // 或者一个字典
  [_db zpm_insertTable:TABLE_NAME dicOrModel:@{@"name": @"小李"}];
```

#### 插入一组数据
```
  // 向TABLE_NAME表中插入一组数据，其中array是一个字典或者model的集合
  [db jq_insertTable:TABLE_NAME dicOrModelArray:array];
```

### 删除
#### 删除一条数据
```
  // 删除最后一条数据
  [_db zpm_deleteTable:TABLE_NAME whereFormat:@"WHERE pkid = (SELECT min(zpid) FROM TABLE_NAME)"];
```

#### 删除表中全部数据
```
  //删除全部数据
  [db zpm_deleteAllDataFromTable:TABLE_NAME];
```

### 更新
#### 指定某条数据的更改
```
  // 更新表中最大的id的名字为小明
  [_db zpm_updateTable:TABLE_NAME dicOrModel:@{@"name":@"小明"} whereFormat:@"WHERE zpid = (SELECT max(zpid) FROM TABLE_NAME)"];
  // 或者是model
  person.name = @"小明";
  [_db zpm_updateTable:TABLE_NAME dicOrModel:person whereFormat:@"WHERE zpid = (SELECT max(zpid) FROM TABLE_NAME)"];
```

### 查找

#### 按条件查找
```
  // 查找表中id是2的数据
  NSArray *personArr = [_db zpm_lookupTable:TABLE_NAME dicOrModel:[Person class] whereFormat:@"where zpid = '2'"];
```

#### 查找表中所有数据
```
  NSArray *personArr = [_db zpm_lookupTable:TABLE_NAME dicOrModel:[Person class]];
```

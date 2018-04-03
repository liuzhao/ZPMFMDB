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



## 创建一个数据库和表
```
    // LIST_NAME:你的表名  [Person class]：你自定义的model类
    ZPMFMDB *db = [ZPMFMDB shareDatabase:@"ZpmHome.sqlite"];
    [db zpm_createTable:LIST_NAME dicOrModel:[Person class]];
```

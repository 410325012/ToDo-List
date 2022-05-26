# ToDo-List

Heroku連結：https://to-do-list-20220526.herokuapp.com/todo

(半小時內若無人使用，會自動進入休眠狀態，稍待片刻即喚醒進入。)

![alt text](https://github.com/410325012/ToDo-List/blob/main/demo.gif)

使用方式：

1、將application.properties調整為合適參數

    spring.datasource.url=jdbc:sqlserver://localhost:1433;databaseName=[YourdatabaseName]
    spring.datasource.username=[Yourusername]
    spring.datasource.password=[Yourpassword]

2、在SQL Server建立資料表

    CREATE TABLE todo(
      id int IDENTITY(1001,1) PRIMARY KEY NOT NULL,
      task nvarchar(50) NOT NULL,
      status nvarchar(5) NOT NULL,
      updatetime datetime2(0)
    );
    
3、匯入專案並開啟連結：http://localhost:8080/todo

# 电影评分系统

额为全额全额
这是一个基于 Spring Boot、MyBatis-Plus、MySQL、JSP 的电影评分系统，不包含影片播放功能。

## 功能

- 管理员：影片新增、删除、修改、查询。
- 游客：查看影片列表和影片详情，注册、登录。
- 登录用户：给影片打分，发表评论。
- 影片详情：显示影片平均分和评论列表。
- 影片海报：后台影片表单的“海报地址”可填写本地静态资源路径或网络图片地址。

## 技术栈

- Spring Boot 3.3.5
- MyBatis-Plus 3.5.9
- MySQL 8.x
- JSP + JSTL
- Maven WAR 打包
- Session 登录
- 不依赖 Lombok，避免不同 JDK 版本下的注解处理兼容问题

## 数据库初始化

1. 在 MySQL 中执行 `src/main/resources/schema.sql`。
2. 设置数据库连接环境变量，或使用默认用户名 `root` 和默认密码 `20051112`。

PowerShell 示例：

```powershell
$env:DB_USERNAME="root"
$env:DB_PASSWORD="你的密码"
```

Windows 命令行建议使用：

```bash
mysql --default-character-set=utf8mb4 -uroot -p你的密码 -e "source C:/Users/38720/Desktop/Daily life/filmevalute/src/main/resources/schema.sql"
```

默认数据库名：

```text
film_evaluate
```

默认管理员账号：

```text
用户名：admin
密码：admin123
```

示例影片已扩充为 20 部，并配置了本地海报，例如：

```text
/static/images/douban/01.jpg
```

## Spring Boot 启动

安装 Maven 后，在项目根目录执行：

```bash
mvn spring-boot:run
```

访问：

```text
http://localhost:8080/movies
```

## Tomcat 部署

打包：

```bash
mvn clean package
```

将 `target/filmevaluate-0.0.1-SNAPSHOT.war` 放入 Tomcat 10 的 `webapps` 目录。

访问地址通常是：

```text
http://localhost:8080/filmevaluate-0.0.1-SNAPSHOT/movies
```

如果把 WAR 改名为 `ROOT.war`，访问地址是：

```text
http://localhost:8080/movies
```

## 说明

- 本项目使用 Spring Boot 3，需要 Java 17 或更高版本。
- Spring Boot 3 对应外部 Tomcat 10 或更高版本。
- 当前项目保留 Spring Boot 主类，也支持外部 Tomcat 以 WAR 方式启动。

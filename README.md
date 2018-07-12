# KISS2U
Keep It Simple, Stupid To You

使用 hmac 认证提交的数据

具体需求：

https://github.com/archlinuxcn/repo/issues/794


### Interface
Interface                 | Function             | Other
------------------------- | -------------------- | -------
GET:  /packages           | 获取全部包状态       | Have cors
GET:  /packages/:pkgname  | 获取指定包的全部日志 |
POST: /packages           | 提交包状态           | Requirement Hmac auth



### Test

```sh
# install postgresql
bundle install
rails db:setup
export KISS2U_AUTH_KEY=key

rails server

sh kiss2u.sh
```

kiss2u System:

* Ruby 2.5.0

* Rails 5.2.0

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

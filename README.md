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


### Feature
- [x] 提交数据认证， hmac 认证
- [x] 过滤重复提交日志，已 lilac 日志写入时间为基准
- [x] 日志解析 （包括版本号有空格的情况）
- [x] latest 表，`successful` or `failed` 次数


* Ruby 2.5.0
* Rails 5.2.0

### Database
> rails 自带的`action_record`几乎支持所用的主流数据库。。。我是在`postgresql`开发测试的。。所以推荐

### Test

```sh
# install postgresql
bundle install
rails db:setup
export KISS2U_AUTH_KEY=key

rails server

sh kiss2u.sh
```

## Todo
- [ ] 监听发送日志脚本 `kiss2u.sh`
- [ ] 前端显示界面
- [ ] .....还有神马？？？


# KISS2U

Keep It Simple, Stupid To You

[![Build Status](https://travis-ci.org/a-wing/KISS2U.svg?branch=master)](https://travis-ci.org/a-wing/KISS2U)

[![codecov](https://codecov.io/gh/a-wing/KISS2U/branch/master/graph/badge.svg)](https://codecov.io/gh/a-wing/KISS2U)

使用 hmac 认证提交的数据

具体需求：

https://github.com/archlinuxcn/repo/issues/794

详细信息：

https://a-wing.top/archlinux/2018/08/05/kiss2u.html

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


* Ruby 2.5.1
* Rails 5.2.0
* inotify-tools

### Database
> rails 自带的`action_record`几乎支持所用的主流数据库。。。~~我是在`postgresql`开发测试的。。所以推荐~~ 目前用SQLite3

### Test

```sh
bundle install
rails db:setup
export KISS2U_AUTH_KEY=key

rails server

```

## Todo
- [x] 监听发送日志脚本 `bin/lilackiss`
- [x] 前端显示界面 [KISS2UI](https://github.com/a-wing/KISS2UI)
- [ ] Orphaning Package
- [ ] .....还有神马？？？


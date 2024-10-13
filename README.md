## DEBUG 编译证书问题

```bash
vim /Users/Shared/debug.kwai.IronMan.xcconfig
```
然后填入以下内容，请使用你自己的bundleId和teamid替换。 

```
debug_bundle_id=com.kwai.xt
debug_development_team_id=W4BAG3EEE5
debug_extension_bundle_id=com.kwai.xt.XTNotificationServiceExtension
```

## 项目编译
依赖`cocoapods`,`swiftlint`,`swiftformat`，安装方式 执行 `bundle`  `./aq_pre_commit.sh`， **安装环境（环境错误可能会造成启动崩溃）** 

执行`aq_pre_commit`安装指定版本`swiftlint`和`swiftformat`，保证代码格式。

## wiki



## 编辑页

### 二级页面

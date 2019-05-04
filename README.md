###文件目录

DemoTest

|- LoginVC 登录首页

|- MainTabVC 主页面（登录成功后进入）


### 重要代码导读

- LoginVC
  登录页面，提供两个输入框，提供给用户输入 account(accid) 与 token。用户点击登录按钮后调用`doLogin`方法，在`doLogin`中调用云信SDK登录方法。登录成功后跳转到会话列表页面`MainTabVC`。

- MainTabVC
  主页面，登录成功后进入。在用户点击登出后调用`doLogout`方法，在`doLogout`方法中调用云信SDK登出方法。登出成功后跳转至登录首页`LoginVC`。


- AppDelegate
  加入了自动登录的方法，在初始化后进入LoginVC前，加入判断是否存在缓存的账号信息，有则进入`MainTabVC`。
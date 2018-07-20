Siri Shortcuts 调研笔记
1.
真机调试，如果想在锁屏界面和搜索界面展示Shortcut，需要在设备中的设置中修改:
Developer ->
- Display Shortcuts: on
- Display Donations On Lock Screen: on

2.
有两种贡献(donate)给Siri的方法
- NSUserActivity：会直接启动App进行后续的处理，可定制化程度低
- NSUserActivity：注意将所需保存的用户信息保存到userInfo中
- INIntent：不启动App，通过Intent Extension和Intent ExtensionUI处理，但当点击UI时仍旧会启动App
- 调试Extension时注意选择attach需要调试的进程，否则无法看到log和断点
- 在- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler NS_AVAILABLE_IOS(8_0);中处理NSUserActivcity或者Intent进行特定的操作

3.
自定义INIntent
新建文件Intent definition file并自定义所需的属性
编译后编辑器会自动生成对应的Intent文件
- tip:注意属性名不要与系统可能的预留字段冲突，如name

4.
Siri的语言对shortcut没有影响

5.
目前问题
- Shortcut只是个快捷方式，没法在调用时自定义参数
- Siri只能识别录制的特定短语
- 只能由用户录制短语，无法在App内部设定特定的短语

参考资料：
- https://medium.com/flawless-app-stories/wwdc-2018-for-ios-developers-siri-shortcuts-e8e4a78f0ad7
- https://developer.apple.com/documentation/sirikit/donating_shortcuts?language=objc
- https://developer.apple.com/videos/play/wwdc2018/211/
- https://developer.apple.com/videos/play/wwdc2018/214/

# flutter_news

如果一点都不熟悉，请参考以下资源:
- [Lab: 一个简单的基础应用](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: 常用的实例](https://flutter.dev/docs/cookbook)
- [在线文档 示例、移动开发指南和完整的API参考](https://flutter.dev/docs)

# 项目集成：
* - 存储
* - 请求（包含加密方式）
* - 骨架屏
* - 导航、图片、输入框、轻提示、确认框组件
* - auto_route
* - 下拉刷新（清盘清理）
* - 在线mock的api
* - 其他小工具（日期、对象、屏幕等方法）
* - ...

# 目录：
* -[flutter配置](#flutter)
* -[flutter切换版本](#flutter切换版本)
* -[APP图标设置](#APP图标设置)
* -[启动图设置](#启动图设置)
* -[升级及热更新](#升级及热更新)
* -[路由配置和使用](#路由配置和使用)
* -[路由生成](#路由生成)
* -[logo生成](#logo生成)
* -[打包以及优化](#打包以及优化)
* -[监控](#监控)
* -[报错和处理](#报错和处理)
* -[相关学习资料](#相关学习资料)
* ...

# flutter

1.下载flutter

2.添加变量
```
export PATH="/xxx/xxx/flutter/bin:$PATH"
export PUB_HOSTED_URL="https://pub.flutter-io.cn"
export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
```

3.vscode/Android Studio 编辑器配置

4.flutter doctor 检测环境  

5.flutter run

# flutter切换版本
1.vim 环境变量配置文件（上面步骤2的文件）
2.export PATH="/xxx/xxx/flutter_xxx/bin:${PATH}"
3.source 变量文件

当然也可以用fvm 进行管理
```
// 安装管理工具
brew install fvm
// 安装版本
fvm install x.x.x(版本号)
// 查看管理的版本
fvm list
// 使用某版本
fvm use x.x.x
```
*最关键*的其实也算打包的事，每次使用终端使用命令切换项目对应SDK版本即可:
```
fvm global x.x.x
```
在fvm目录下自动生成了一个default文件夹，终端cd一下目录，写入~/.zshrc文件内即可。
>注意（很关键）：在~/.bash_profile 或者 ~/.zshrc内要配置成这样：
```
export PATH=/路径/fvm/default/bin:$PATH
export PATH=/路径/fvm/default/bin/cache/dart-sdk/bin:$PATH
```
> 还要注意要记得：
```
source ~/.zshrc
```


# APP图标设置
1.Android
/android/app/src/main/res目录，里面包含了各种资源文件夹，只需按照Android开发人员指南 (opens new window)中的说明，
将其替换为所需的资源，并遵守每种屏幕密度（dpi）的建议图标大小标准。
>注意: 如果重命名.png文件，则必须在AndroidManifest.xml的<application>标签的android:icon属性中更新名称。

2.IOS
/ios/Runner/Assets.xcassets/AppIcon.appiconset 目录已经包含占位符图片，只需将它们替换为适当大小的图片，保留原始文件名称。

# 启动图设置
1.Android
* /android/app/src/main/res/drawable(drawable-xx)/launch_background.xml
* 通过自定义drawable来实现自定义启动界面，也可以直接换一张图片

2.iOS
* /ios/Runner/Assets.xcassets/LaunchImage.imageset目录进行替换
* 使用不同的文件名，那必须更新同一目录中的Contents.json文件


# 升级及热更新
- APK ：参考上面的打包
- 差异更新 ：按照需求和业务配置来进行差异化处理，各有不同
- 热更新 （使用 Tinker 去实现 Flutter 的热更新 HotfixFlutter，可以查看链接：[zhihu](https://zhuanlan.zhihu.com/p/157268394)）：
 - 1、down 下来后，打开 flutterhotfixmodule 项目，open -> HotFixFlutter -> flutterhotfixmodule，再打开 pubspec.yaml，点击 Pub get，执行完成。
 - 2、打开 HotFixFlutter，切换到 Project 下，打开根目录的 settings.gradle，把下面的配置 copy 进去：
```
setBinding(new Binding([gradle: this]))
evaluate(new File(settingsDir.parentFile, '/HotFixFlutter/flutterhotfixmodule/.android/include_flutter.groovy'))
include ':flutterhotfixmodule'
```
点击 Sync Now，执行完成，就会出现项目结构。
 - 3、在 App 的 gradle 里，配置下面 flutter 和 flutterboost 的依赖，再次 Sync Now
```
implementation project(':flutter')
implementation project(':flutter_boost')
```
 - 4、把 bugly id 复制到 bugly 初始化里面：
```
Bugly.init(this, "你的bugly id", true);
```
运行 gradle 下面的 assembleRelease 任务，执行完成，安装 build -> bakApk -> 带有日期文件夹 -> app-release.apk。
 - 5、去 flutterhotfixmodule 项目下修改 dart 代码，以及添加加载图片资源。修改完后回到 HotfixFlutter 项目下，
把 build -> bakApk 下生成目录上的安装日期抄写到 tinker-support.gradle 里的 baseApkDir 里执行。
 - 6、进入 bugly 官网，打开热更新页面，点击发布新补丁，找到 build -> outputs -> patch -> patch_signed_7zip.apk，上传完成，
点击全量设备（只限测试，别整个生产的 bugly id 进来），立即下发。稍微等待那么一小会，杀掉应用，再重新打开，会出现：
```
PatchResult:
isSuccess: true
...
```
代表补丁已经打上去了，杀掉应用，再次打开进去 flutter 页面，修复成功。

# 路由配置和使用
> 项目集成了auto_route
1.添加路由：
lib/router/index.dart配置管理文件
```
// 默认打开页面路由
AutoRoute(page: HomePage, initial: true),
// 默认添加格式
AutoRoute(page: SignInPage),
// 有自定义别称的路由
AutoRoute(page: SignUpPage, path: '/signup'),
// 有转场的路由
CustomRoute(page: DetailsPage, transitionsBuilder: zoomInTransition),
```
2.使用方式：
```
// push跳转
router(context).push(const SignUpPage());
// 跳转–命名路由Navigator.pushNamed，需要配合路由表在main.dart中
// 如果是非autoRouter的话，routes里面需要设置一下别称 "/signup": (context) => SignUpPage()
// 如果是autoRouter的话, 查看是否自定义，自定义的话用自定义的，没自定义的话查看一下router里面生成的*.gr.dark文件，对应的页面的path
router(context).pushNamed(
   "/signup"
);
// 常规跳转，没有携带参数
Navigator.push(context, MaterialPageRoute(builder: (context){
   return const SignUpPage();
}));
// 跳转–Navigator.push+参数
var callBackReturn = await Navigator.push(
   context,
   MaterialPageRoute(builder: (context){
       return const SignUpPage();
   },
       settings: const RouteSettings(arguments: '我是来自signInPage页面的参数'),
   )
);
```


# 路由生成
```
// watch
flutter packages pub run build_runner watch
// build
flutter packages pub run build_runner build
```
>注意：检测到冲突的输出，生成无法提示获取删除它们的权限。其实就是已经生成过了，需要覆盖一下，加上这个参数 -delete-conflicting-outputs 就行了

# logo生成
```
flutter pub run icons_launcher:create
```
>This 'icons_launcher:main' is deprecated. Use 'icons_launcher:create' instead.

# 打包
# 安卓
- 常规打包：
```
flutter build apk
```
- so优化:
- Flutter打包Apk会包含三种CPU架构信息以适配不同架构的设备(x86_64,arm64-v8a,armeabi-v7a)
- 目前大部分手机都是armeabi-v7a这个架构，可以分架构分别打包,包体减小较明显,但是需要舍弃小部分机型
- 1.flutter build apk 表示当前构建 release 包
- 2.android-arm,android-arm64,android-x64则是指定生成对应架构的release包
- 3.--split-per-abi表示告知需要按照指定的类型分别打包，如果移除则直接构建包含所有 CPU 架构的 Apk 包
```
flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi
或
flutter build apk --split-per-abi
```
-对于混淆（可以增加逆向难度还有减少Apk大小）
```
flutter build apk --obfuscate --split-debug-info=xx
```
- 1.--obfuscate 开启混淆操作
- 2.--split-debug-info= 将因混淆生成的 map 符号表缓存到此位置

so优化和混淆同时使用打包命令:
```
flutter build apk --obfuscate --split-debug-info=debugInfo --target-platform android-arm,android-arm64,android-x64 --split-per-abi
```
# IOS
-常规打包：
```
flutter build ios --release
```
- 1.xcode辅助方案（目前应该不能上架只能蒲公英发布）
- A.xcode->ios->Flutter->Open iOS module in Xcode
- B.点击Runner, 设备选择Generic iOS Device
- C.xCode 菜单栏选择Product->Analyze...
- D.Products文件夹生成该 app 右键 ->Show in Finder
- E.该目录下新建一个Payload文件夹, 并将该 app 拖进去->压缩"Payload"->Payload.zip -> 文件更名为 xxx.ipa 安装包
- 2.综合优化(弃架构armv7等配置优化）
- A.配置编译选项Build setttings -> Levels -> Generate Debug Symbols -> Release -> No
- (注意：这个如果设置NO，不会在断点处停下)
- B.Valid Architectures（如果有这个配置项的xcode的话，去掉 armv7 (用于支持4s和4）)
- C.去掉无用的三方库、代码、readme等
- D.图片处理
- (
在线压缩 [compresspng.com](https://compresspng.com/zh/)、[tinypng](https://tinypng.com/)等、
去掉无用的图片、
Assets.xcassets管理（File -> New -> File…… -> iOS -> Resource -> Asset Catalog）
)
- E.配置编译选项
- Build setttings -> Levels ->Linking -> Dead Code Stripping -> YES
- (代码已定义但从未被调用的剥离，也就是所谓的冗余代码)
- F.编译器优化级别：
- Build Settings -> Levels ->Optimization Level->release->Fastest, Smalllest[-Os]
- G.去除不必要的调试符号:
- Build setttings -> Levels ->Strip Debug Symbols During Copy、Symbols Hidden by Default->release->Yes
(Symbols Hidden by Default将会把所有符号都定义成private extern，从而减小体积)
- H.符号表剥离:
- Build setttings -> Levels -> Strip Linked Product -> (Debug -> No) Release -> YES
（二进制文件中将根据 strip style 的值进行符号表剥离）
（
- 补充strip style的规则解释：
all symbols（所有符号）:符号表中将执行最激进的剥离策略，最终符号表中只包含最核心的方法；
Non globals（非全局符号）: 类型会剥离应用中不同模块中共同使用的直接符号，但会留下用于其他APP中的符号；
Debugging symbols（删除了第三种 nlist 类型的符号）：保留直接符号；
）
其他了解可以查看iOS符号化基础与进阶的文档


# 监控（[flutterfire-github](https://github.com/firebase/flutterfire) [firebase](https://firebase.flutter.dev/) [firebase中文](https://firebase.google.cn/docs/cli?hl=zh-cnΩ)）
1、配置firebase的初始化
```
curl -sL https://firebase.tools | bash
```
2、通过运行以下命令，使用您的 Google 帐户登录 Firebase
```
firebase login
```
3、通过从任何目录运行以下命令来安装 FlutterFire CLI：
```
dart pub global activate flutterfire_cli
```
4、在 Flutter 项目目录中，运行以下命令来启动应用配置工作流：
```
flutterfire configure
```

在项目中初始化：
1、在 Flutter 项目目录中，运行以下命令来安装核心插件：
```
flutter pub add firebase_core
```
2、在 Flutter 项目目录中，运行以下命令以确保 Flutter 应用的 Firebase 配置是最新的：
```
flutterfire configure
```
3、在您的lib/main.dart文件中，导入 Firebase 核心插件和您之前生成的配置文件
```
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
```
4、同样在您的lib/main.dart文件中，使用配置文件导出的DefaultFirebaseOptions对象初始化 Firebase：
```
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```
5、重建你的 Flutter 应用程序：
```
flutter run
```

添加性能监控：
1、在 Flutter 项目的根目录中，运行以下命令来安装性能监控 Flutter 插件：
```
flutter pub add firebase_performance
```
2、在 Flutter 项目的根目录中，运行以下命令：
```
flutterfire configure
```
（运行此命令可确保Flutter应用的Firebase配置是最新的，并且对于Android，将所需的性能监控Gradle插件添加到您的应用中。）
3、完成后，重新构建您的 Flutter 项目：
```
flutter run
```
添加性能监控 SDK 后，Firebase 会自动开始收集与应用生命周期相关的数据（例如应用启动时间），以及HTTP/S 网络请求的数据。

# 报错和处理
1.显示未安装CocoaPods（Exception: CocoaPods not installed or not in valid state）
```
open /Applications/Android\ Studio.app
```
2.flutter build ios --release报错：
```
It appears that your application still contains the default signing identifier.
Try replacing 'com.example' with your signing id in Xcode:
  open ios/Runner.xcworkspace
```
https://stackoverflow.com/questions/56185013/it-appears-that-your-application-still-contains-the-default-signing-identifier/64017598


# 相关学习资料

B站视频地址：https://space.bilibili.com/404904528/channel/seriesdetail?sid=771285&ctype=0

在线图文地址：https://ducafecat.gitee.io/categories/Flutter-%E5%AE%9E%E6%88%98%E4%BB%8E%E9%9B%B6%E5%BC%80%E5%A7%8B/

github源码代码地址：https://github.com/ducafecat/flutter_learn_news



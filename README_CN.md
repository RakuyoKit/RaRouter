# RaRouter

<p align="center">
<img src="https://raw.githubusercontent.com/rakuyoMo/RaRouter/master/Images/logo.png" alt="RaRouter" title="RaRouter" width="1000"/>
</p>

<p align="center">
<a><img src="https://img.shields.io/badge/language-swift-ffac45.svg"></a>
<a href="https://github.com/rakuyoMo/RaRouter/releases"><img src="https://img.shields.io/cocoapods/v/RaRouter.svg"></a>
<a href="https://github.com/rakuyoMo/RaRouter/blob/master/LICENSE"><img src="https://img.shields.io/cocoapods/l/RaRouter.svg?style=flat"></a>
</p>

`RaRouter` 是一个面向协议的轻量级路由框架。

通过使用框架提供默认的类型，或者自定义路由，您可以快速搭建自己的路由组件，进而解耦自己的项目。

## 基本要求

- 运行 **iOS 9** 及以上版本的设备。
- 使用 **Xcode 10** 及以上版本编译。
- **Swift 5.0** 以及以上版本。

## 安装

### CocoaPods

```ruby
pod 'RaRouter'
```

## 功能

- [x] 支持根据**路由字符串**执行对应的内容，或获得某些返回值。
- [x] **面向协议**，提供非常高的自由度，供您自定义路由操作。
- [x] 新增/移除路由组件时，**无需**增加/减少任何注册相关的代码。
- [x] 可以通过封装，**集中定义、隐藏**路由字符串，减少硬编码带来的风险。
- [x] 可以通过封装，在执行路由时保持**类型严格**。

## 使用

相关内容请参考 wiki: [快速入门](https://github.com/rakuyoMo/RaRouter/wiki/快速入门)。

## 预览

下面的代码展示了使用 `RaRouter` 封装的模块：`ModuleA`。借助这段代码，您可以对 `RaRouter` 有一个初步的印象：

> 更多功能，以及完整的示例代码可以参考随仓库配套提供的 demo（在 `Examples` 目录下）。

```swift
// In the `Interface.swift` file of the router project
public enum ModuleA: ModuleRouter {
    
    public typealias Table = RouterTable
    
    public enum RouterTable: String, RouterTableProtocol {
        
        public var url: String { rawValue }
        
        case create         = "rakuyo://moduleA/create"
        case doSomething    = "rakuyo://moduleA/do/something"
        case calculateFrame = "rakuyo://moduleA/calculate/frame" 
    }
}

public extension Router where Module == ModuleA {
    
    static func doSomething(start: Date, end: Date) -> DoResult {
        return Router.do(.doSomething, param: (start, end))
    }

    static func calculateFrame(with screenWidth: CGFloat) -> GetResult<CGRect> {
        return Router.get(of: CGRect.self, from: .calculateFrame, param: screenWidth)
    }
    
    static func create() -> ViewControllerResult {
        return Router.viewController(from: .create)
    }
}

// In the `Register.swift` file of the core project
private class ModuleARegister: RouterRegister {
    
    static func register() {
        
        let router = Router<ModuleA>.self
        
        router.register(for: .doSomething) { (url, value) -> DoResult in
            
            guard let param = value as? (start: Date, end: Date) else {
                return .failure(.parameterError(url: url, parameter: value))
            }
            
            print("We are doing these things from \(param.start) to \(param.end)")
            return .success(())
        }
        
        router.register(for: .calculateFrame) { (url, value) -> GetResult<CGRect> in
            
            guard let screenWidth = value as? CGFloat else {
                return .failure(.parameterError(url: url, parameter: value))
            }
            
            return .success(CGRect(x: 0, y: 0, width: screenWidth * 0.25, height: screenWidth))
        }
        
        router.register(for: .create) { (url, value) -> ViewControllerResult in
            return .success(UIViewController())
        }
    }
}

// In the `AppDelegate.swift` file of the core project
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    // some codes with higher priority than registered routes

    // initialize modules
    Router<Modules>.initialize()

    // some other code ..
}
```

## 参考

在开发过程中，我主要参考了 [URLNavigator](https://github.com/devxoul/URLNavigator) 这个伟大的开源组件。感觉作者的贡献！

## License

`RaRouter` 在 **MIT** 许可下可用。 有关更多信息，请参见 [LICENSE](https://github.com/rakuyoMo/RaRouter/blob/master/LICENSE) 文件。

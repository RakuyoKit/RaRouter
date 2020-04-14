# RaRouter

<p align="center">
<a><img src="https://img.shields.io/badge/language-swift-ffac45.svg"></a>
<a href="https://github.com/rakuyoMo/RaRouter/releases"><img src="https://img.shields.io/cocoapods/v/RaRouter.svg"></a>
<a href="https://github.com/rakuyoMo/RaRouter/blob/master/LICENSE"><img src="https://img.shields.io/cocoapods/l/RaRouter.svg?style=flat"></a>
</p>

`RaRouter` 是一个面向协议的轻量级路由 ，通过使用默认提供的类型，或自定义 Router，您可以快速搭建自己的路由组件，进而解耦自己的项目。

## 基本要求

- 运行 **iOS 10** 及以上版本的设备。
- 使用 **Xcode 10** 及以上版本编译。
- **Swift 5.0** 以及以上版本。

## 安装

### CocoaPods

```ruby
pod 'RaRouter'
```

## 使用

> 下面的内容将告诉您如何使用该库，但基本不会说 "**为什么**"。更多内容见 [wiki](https://github.com/rakuyoMo/RaRouter/wiki)。完整的代码示例可以参考 demo
> 中的内容

### 执行路由

`RaRouter` 默认提供以下三种路由操作：

- `do`： 执行某些操作：

```swift
let router = "rakuyo://moduleA/do/something"

try? Router<Global>.do(router, param: ("参数1", 2))
```

- `getResult`：执行某些操作，并获得其返回值：

```swift
let router = "rakuyo://moduleA/calculate/frame"

let result = try? Router<Global>.getResult(router, param: "参数")
```

- `viewController`：执行某些操作，并获得其返回的 `UIViewController` 子类：

```swift
let router = "rakuyo://moduleA/create"

let controller = try? Router<Global>.viewController(router)
```

一些解释：

1. 在执行路由的过程中，如果出现错误，`RaRouter` 内部将会抛出异常（`RouterError`）。所以在执行路由时，需要添加 `try`。

2. 对于 `param` 参数，其为 `Any?` 类型，默认为 `nil`。这意味着您可以传递任何您想要的参数，并且不受任何的限制。

    例如上面的 `do` 示例中，我传入了一个 `(String, Int)` 类型的元组，而 `getResult` 实例中，我只传入了一个 `String`。到了 `viewController
`，因为从编码上来说 `"rakuyo://moduleA/create"` 不需要任何参数（假如我们编写了那些代码），所以我可以省略 `param`。

3. 对于 `Global` 泛型，将在后面的小节中将详细介绍。

### 封装

我们还可以再优化一下上面的代码，例如封装一下 `router`：

```swift
public enum ModuleA: ModuleRouter {
    
    public typealias Table = RouterTable
    
    public enum RouterTable: String, RouterTableProtocol {
        
        public var url: String { rawValue }
        
        case create         = "rakuyo://moduleA/create"
        case doSomething    = "rakuyo://moduleA/do/something"
        case calculateFrame = "rakuyo://moduleA/calculate/frame" 
    }
}
```

上面的代码定义了一个模块 `ModuleA`，其中封装了它所包含的 "**功能**"。

接着还可以再封装一下 "操作"：

```swift
public extension Router where Module == ModuleA {
    
    static func create() throws -> UIViewController {
        return try Router.viewController(.create)
    }

    static func doSomething(start: Date, end: Date) throws {
        try Router.do(.doSomething, param: (start, end))
    }

    static func calculateFrame(with screenWidth: CGFloat) throws -> CGRect {
        return try Router.getResult(.calculateFrame, param: screenWidth)
    }
}
```

现在，当我们再执行 [执行路由](#执行路由) 一节的测试代码时，我们可以这么写：

```swift
// for `viewController`
let controller = try? Router<ModuleA>.create()

// for `do`
try? Router<ModuleA>.doSomething(start: Date(), end: Date())

// for `getResult`
let frame = try? Router<ModuleA>.calculateFrame(with: 375)
```

### 注册

最后，我们需要注册刚刚定义的路由。

对于默认提供的三种操作，每种操作都有不同的注册方法。而它们的区别在于闭包的返回值不同：

- `viewController`

其闭包的返回值规定为 `UIViewController` 或其子类：

```swift
Router<Global>.register(for: "your router") { (url, value) throws -> UIViewController in
    return // your controller
}
```

- `do`

其闭包的返回值规定为 `Void`（注意该 `Void` 不可省略）：

```swift
Router<Global>.register(for: "your router") { (url, value) throws -> Void in
    // do something
}
```

- `getResult`

其闭包的返回值规定为 `Any?`，您可以扩展为任意您需要的非 `UIViewController` 以及 `Void` 类型，例如 `CGRect`

```swift
Router<Global>.register(for: "your router") { (url, value) throws -> CGRect in
    return .zero // Anything you need
}
```

对于[封装](#封装)一节中的示例，我们应该如下编写 `ModuleA` 对应的注册代码：

```swift
// Following the `RouterRegister` protocol is the key
private class ModuleARegister: RouterRegister {
    
    static func register() {
        
        let router = Router<ModuleA>.self
        
        router.register(for: .create) { (url, value) throws -> UIViewController in
            return UIViewController()
        }
        
        router.register(for: .doSomething) { (url, value) throws -> Void in
            
            guard let param = value as? (start: Date, end: Date) else {
                throw RouterError.parameterError(url: url, parameter: value)
            }
            
            print("We are doing these things from \(param.start) to \(param.end)")
        }
        
        router.register(for: .calculateFrame) { (url, value) throws -> CGRect in
            
            guard let screenWidth = value as? CGFloat else {
                throw RouterError.parameterError(url: url, parameter: value)
            }
            
            return CGRect(x: 0, y: 0, width: screenWidth * 0.25, height: screenWidth)
        }
    }
}
```

最后的最后，在 `AppDelegate.swift` 的 `application(_:, didFinishLaunchingWithOptions:)` 方法中执行注册代码：

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    // some codes with higher priority than registered routes

    // initialize modules
    Router<Modules>.initialize()

    // some other code ..
}
```

--------

更多内容请参考 [wiki](https://github.com/rakuyoMo/RaRouter/wiki)
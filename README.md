# RaRouter

<p align="center">
<img src="https://raw.githubusercontent.com/rakuyoMo/RaRouter/master/Images/logo.png" alt="RaRouter" title="RaRouter" width="1000"/>
</p>

<p align="center">
<a><img src="https://img.shields.io/badge/language-swift-ffac45.svg"></a>
<a href="https://github.com/rakuyoMo/RaRouter/releases"><img src="https://img.shields.io/cocoapods/v/RaRouter.svg"></a>
<a href="https://github.com/rakuyoMo/RaRouter/blob/master/LICENSE"><img src="https://img.shields.io/cocoapods/l/RaRouter.svg?style=flat"></a>
</p>

> [中文](https://github.com/rakuyoMo/RaRouter/blob/master/README_CN.md)

`RaRouter` is a lightweight protocol-oriented router. By using the type provided by default or customizing the
 Router, you can quickly build your own routing component and decouple your own projects.

## Prerequisites

- **iOS 9 or later**.
- **Xcode 10.0 or later** required.
- **Swift 5.0 or later** required.

## Installation

### CocoaPods

```ruby
pod 'RaRouter'
```

## Quick start

> The following content will tell you how to use, but basically will not explain "**why**". See [wiki](https://github.com/rakuyoMo/RaRouter/wiki) for more content. The complete code example can refer to the content in the demo

### Execute route

`RaRouter` provides the following three routing operations by default:

- `do`: execute certain operations:

```swift
let router = "rakuyo://moduleA/do/something"

_ = Router<Global>.do(router, param: ("parameter", 1))
```

- `get`: execute some operation and get its return value:

```swift
let router = "rakuyo://moduleA/calculate/frame"

let result = Router<Global>.get(of: String.self, from: router, param: "parameter")

switch result {
case .success(let string):
    print(string)
    
case .failure(let error):
    print(error)
}
```

- `viewController`: execute certain operations and get the returned`UIViewController` subclass:

```swift
let router = "rakuyo://moduleA/create"

let result = Router<Global>.viewController(from: router)

switch result {
case .success(let controller):
    print(controller)
    
case .failure(let error):
    print(error)
}
```

Some explanations:

1. For the `param` parameter, it is of type` Any? `, And the default is `nil`. This means that you can pass
 any parameters you want without any restrictions.

    For example, in the `do` example above, I passed in a tuple of type`(String, Int)`, while in the
     `get` instance, I only passed in a `String`. When we arrived at `viewController`, because coding
     said `"rakuyo://moduleA/create"` did not require any parameters (*if we wrote those codes*), So you can omit `param`.

2. For the `Global`, it will be introduced in [Advanced Tutorial](https://github.com/rakuyoMo/RaRouter/wiki/进阶教程#global).

### Encapsulation

We can also optimize the above code, for example, encapsulate `router`:

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

The above code defines a module `ModuleA`, which encapsulates the "**function**" it contains.

Then you can also encapsulate the "**operation**":

```swift
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
```

Now, when we execute the test code in the [Execute route](#execute-route) section, we can write:

```swift
// for `do`
_ = Router<ModuleA>.doSomething(start: Date(), end: Date())

// for `get`
if case let .success(frame) = Router<ModuleA>.calculateFrame(with: 375) { }

// for `viewController`
if case let .success(controller) = Router<ModuleA>.create() { }
```

### Request

Finally, we need to register the route we just defined.

For the three operations provided by default, each operation has a different registration method. The difference between them lies in the return value of the closure:

- `do`

The return value of its closure is specified as `DoResult` (` Result<Void, RouterError>`):

```swift
Router<Global>.register(for: "your router") { (url, value) -> DoResult in
    // do something
    return .success(())
}
```

- `get`

The return value of its closure is specified as `GetResult<T>` (`Result<T, RouterError>`):

You can expand it to any type you need that is not `UIViewController` and `Void`, such as `CGRect`:

```swift
Router<Global>.register(for: "your router") { (url, value) -> GetResult<CGRect> in
    return .success(.zero)  // Anything you need
}
```

- `viewController`

The return value of its closure is specified as `ViewControllerResult` (` Result<UIViewController, RouterError>`):

```swift
Router<Global>.register(for: "your router") { (url, value) -> ViewControllerResult in
    return .success(UIViewController()) // your controller
}
```

For the example in the [Encapsulation](#Encapsulation) section, we should write the registration code
 corresponding to `ModuleA` as follows:

```swift
// Following the `RouterRegister` protocol is the key
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
```

At the end, the registration code is executed in the `application (_ :, didFinishLaunchingWithOptions:)` method of `AppDelegate.swift`:

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    // some codes with higher priority than registered routes

    // initialize modules
    Router<Modules>.initialize()

    // some other code ..
}
```

--------

For more information, please see [wiki](https://github.com/rakuyoMo/RaRouter/wiki)

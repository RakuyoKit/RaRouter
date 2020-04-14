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

- Apps using `RaRouter` can target: **iOS 9 or later**.
- **Xcode 10.0 or later** required.
- **Swift 5.0 or later** required.

## Installation

### CocoaPods

```ruby
pod 'RaRouter'
```

## Feature

> The following content will tell you how to use, but basically will not explain "**why**". See [wiki](https://github.com/rakuyoMo/RaRouter/wiki) for more content. The complete code example can refer to the content in the demo

### Execute route

`RaRouter` provides the following three routing operations by default:

- `do`: execute certain operations:

```swift
let router = "rakuyo://moduleA/do/something"

try? Router<Global>.do(router, param: ("parameter", 1))
```

- `getResult`: execute some operation and get its return value:

```swift
let router = "rakuyo://moduleA/calculate/frame"

let result = try? Router<Global>.getResult(router, param: "parameter")
```

- `viewController`: execute certain operations and get the returned`UIViewController` subclass:

```swift
let router = "rakuyo://moduleA/create"

let controller = try? Router<Global>.viewController(router)
```

Some explanations:

1. During the execution of routing, if an error occurs, an exception will be thrown inside `RaRouter` (`RouterError`). So when performing routing, you need to add `try`.

2. For the `param` parameter, it is of type` Any? `, And the default is `nil`. This means that you can pass
 any parameters you want without any restrictions.

    For example, in the `do` example above, I passed in a tuple of type`(String, Int)`, while in the
     `getResult` instance, I only passed in a `String`. When we arrived at `viewController`, because coding
      said `"rakuyo://moduleA/create"` did not require any parameters (*if we wrote those codes*), I can
       omit `param`.

3. For the `Global` generic, it will be described in detail in a later section.

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

Now, when we execute the test code in the [Execute route](#execute-route) section, we can write:

```swift
// for `viewController`
let controller = try? Router<ModuleA>.create()

// for `do`
try? Router<ModuleA>.doSomething(start: Date(), end: Date())

// for `getResult`
let frame = try? Router<ModuleA>.calculateFrame(with: 375)
```

### Request

Finally, we need to register the route we just defined.

For the three operations provided by default, each operation has a different registration method. The difference between them lies in the return value of the closure:

- `viewController`

The return value of its closure is specified as `UIViewController` or its subclasses:

```swift
Router<Global>.register(for: "your router") { (url, value) throws -> UIViewController in
    return // your controller
}
```

- `do`

The return value of its closure is specified as `Void` (`Void` cannot be omitted):

```swift
Router<Global>.register(for: "your router") { (url, value) throws -> Void in
    // do something
}
```

- `getResult`

The return value of the closure is specified as `Any?`, You can expand it to any type you need that is not
 `UIViewController` and `Void`, such as `CGRect`

```swift
Router<Global>.register(for: "your router") { (url, value) throws -> CGRect in
    return .zero // Anything you need
}
```

For the example in the [Encapsulation](#Encapsulation) section, we should write the registration code
 corresponding to `ModuleA` as follows:

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

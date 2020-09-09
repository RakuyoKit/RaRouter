# RaRouter

<p align="center">
<img src="https://raw.githubusercontent.com/rakuyoMo/RaRouter/master/Images/logo.png" alt="RaRouter" title="RaRouter" width="1000"/>
</p>

<p align="center">
<a><img src="https://img.shields.io/badge/language-swift-ffac45.svg"></a>
<a href="https://github.com/rakuyoMo/RaRouter/releases"><img src="https://img.shields.io/cocoapods/v/RaRouter.svg"></a>
<a href="https://github.com/rakuyoMo/RaRouter/blob/master/LICENSE"><img src="https://img.shields.io/cocoapods/l/RaRouter.svg?style=flat"></a>
</p>

> *The following content is based on the `2.0.0-beta.1` version, and its content may be changed at any time.*

> [中文](https://github.com/rakuyoMo/RaRouter/blob/master/README_CN.md)
 
 `RaRouter` is a lightweight protocol-oriented router framework.

 By using the framework to provide default types, or custom router, you can quickly build your own routing components, and then decouple your own projects.

## Prerequisites

- **iOS 10 or later**.
- **Xcode 10.0 or later** required.
- **Swift 5.0 or later** required.

## Install

### CocoaPods

```ruby
pod 'RaRouter'
```

## Features

- [x] Support to execute the corresponding content according to **router string**, or get some return
 value.
- [x] **Protocol-oriented**, providing a very high degree of freedom for you to customize router
 operations.
- [x] When adding/removing router components, **no need to** add/remove any registration related codes.
- [x] Through encapsulation, **collectively define and hide** router strings to reduce the risk of hard
 coding.
- [x] You can keep the **type strict** when performing router through encapsulation.

## Usage

For related content, please refer to wiki: [Quick Start](https://github.com/rakuyoMo/RaRouter/wiki/Quick-start).

## Preview

The following code shows the module encapsulated with `RaRouter`: `ModuleA`. 

With this code, you can have a preliminary impression of `RaRouter`:

> For more functions and complete sample code, please refer to the demo provided with the warehouse (under the `Examples` directory).

```swift
// In the `Interface.swift` file of the router project
public enum ModuleA: ModuleRouter {
    
    public struct Factory: RouterFactory {
        public init() {}
    }
    
    public enum Table: String, RouterTable {
        
        case create         = "RaRouter://ModuleA/create"
        case doSomething    = "RaRouter://ModuleA/do/something"
        case calculateFrame = "RaRouter://ModuleA/calculate/frame" 
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
extension Test.Factory: FactoryMediator {
    
    public var source: RouterFactory { RealFactory() }

    private struct RealFactory: RouterFactory {
        
        lazy var doHandlerFactories: [String : DoHandlerFactory]? = [
            
            ModuleA.Table.doSomething.rawValue : { (url, value) -> DoResult in
                
                guard let param = value as? (start: Date, end: Date) else {
                    return .failure(.parameterError(url: url, parameter: value))
                }
                
                print("We are doing these things from \(param.start) to \(param.end)")
                return .success(())
            }
        ]
        
        lazy var getHandlerFactories: [String : GetHandlerFactory]? = [
            
            ModuleA.Table.calculateFrame.rawValue : { (url, value) -> GetResult<AnyResult> in
                
                guard let screenWidth = value as? CGFloat else {
                    return .failure(.parameterError(url: url, parameter: value))
                }
                
                return .success(CGRect(x: 0, y: 0, width: screenWidth * 0.25, height: screenWidth))
            }
        ]
        
        lazy var viewControllerHandlerFactories: [String : ViewControllerHandlerFactory]? = [
            
            ModuleA.Table.create.rawValue : { (url, value) -> ViewControllerResult in
                return .success(UIViewController())
            }
        ]
    }
}
```

## Reference

During the development process I referred to [URLNavigator](https://github.com/devxoul/URLNavigator), a great open source component. Feel the author's contribution!

## License

`RaRouter` is available under the **MIT** license. See the [LICENSE](https://github.com/rakuyoMo/RaRouter/blob/master/LICENSE) file for more info.

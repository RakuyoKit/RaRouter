//
//  Typealias.swift
//  RaRouter
//
//  Created by Rakuyo on 2020/4/7.
//  Copyright © 2020 Rakuyo. All rights reserved.
//

import UIKit

public typealias DoResult = Result<Void, RouterError>
public typealias DoResultCallback = (DoResult) -> Void
public typealias DoHandlerFactory = (_ url: String, _ values: Any?) -> DoResult
public typealias AsynDoHandlerFactory = (_ url: String, _ values: Any?, _ callback: @escaping DoResultCallback) -> Void

public typealias GetResult<T> = Result<T, RouterError>
public typealias AnyResult = Any?
public typealias GetResultCallback = (GetResult<AnyResult>) -> Void
public typealias GetHandlerFactory = (_ url: String, _ values: Any?) -> GetResult<AnyResult>
public typealias AsynGetHandlerFactory = (_ url: String, _ values: Any?, _ callback: @escaping GetResultCallback) -> Void

public typealias ViewControllerResult = Result<UIViewController, RouterError>
public typealias ViewControllerResultCallback = (ViewControllerResult) -> Void
public typealias ViewControllerHandlerFactory = (_ url: String, _ values: Any?) -> ViewControllerResult
public typealias AsynViewControllerHandlerFactory = (_ url: String, _ values: Any?, _ callback: @escaping ViewControllerResultCallback) -> Void

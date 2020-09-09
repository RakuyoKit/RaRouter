# pod lib lint --verbose --allow-warnings RootControllerRouter.podspec
# pod trunk push --verbose --allow-warnings RootControllerRouter.podspec

Pod::Spec.new do |s|
  
  s.name             = 'RootControllerRouter'
  
  s.version          = '1.0.0-Router'
  
  s.summary          = 'ModuleA Router.'
  
  s.description      = 'ModuleA Router.'
  
  s.homepage         = 'https://github.com/rakuyoMo/RaRouter'
  
  s.license          = 'MIT'
  
  s.author           = { 'Rakuyo' => 'rakuyo.mo@gmail.com' }
  
  s.source           = { :git => '', :tag => s.version.to_s }
  
  s.requires_arc     = true
  
  s.platform         = :ios, '10.0'
  
  s.swift_version    = '5.0'
  
  s.static_framework = true
  
  s.module_name      = 'RootControllerRouter'
    
  s.source_files     = 'RootControllerRouter/Router/*'
  
  s.dependency 'RaRouter', '>= 2.0.0-beta.1'
  
end

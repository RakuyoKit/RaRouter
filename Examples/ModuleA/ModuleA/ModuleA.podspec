# pod lib lint --verbose --allow-warnings ModuleA.podspec
# pod trunk push --verbose --allow-warnings ModuleA.podspec

Pod::Spec.new do |s|
  
  s.name          = 'ModuleA'
  
  s.version       = '1.0.0'
  
  s.summary       = 'ModuleA'
  
  s.description   = 'ModuleA'
  
  s.homepage      = 'https://github.com/rakuyoMo/RaRouter'
  
  s.license       = 'MIT'
  
  s.author        = { 'Rakuyo' => 'rakuyo.mo@gmail.com' }
  
  s.source        = { :git => '', :tag => s.version.to_s }
  
  s.requires_arc  = true
  
  s.platform      = :ios, '10.0'
  
  s.swift_version = '5.0'
  
  s.module_name   = 'ModuleA'
  
  s.static_framework = true
  
  s.source_files = 'ModuleA/Core/', 'ModuleA/Router/'
  
  s.dependency 'ModuleARouter', '>= 1.0.0-Router'
  
end

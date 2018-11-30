
Pod::Spec.new do |s|
  s.name         = "testPersionalcocoapods"
  s.version      = "0.0.8"
  s.summary      = "
		文件管理
"

  s.description  = <<-DESC
			文件管理、用户信息管理（用户信息需要自行添加相对应的属性）
                   DESC

  s.homepage     = "https://github.com/hsdji/testPersionalcocoapods"
  s.license      = "MIT"
  s.author             = { "单小飞" => "2530101715@qq.com" }
  s.source           = {:git => 'https://github.com/hsdji/testPersionalcocoapods.git', :tag => s.version}
  s.platform     = :ios, "9.0"

  s.dependency 'AFNetworking', '~> 2.3'

  s.source_files = 'test/Classes/*.{h,m}','Pods'
  

  
 
end
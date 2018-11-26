

Pod::Spec.new do |s|
  s.name         = "testPersionalcocoapods"
  s.version      = "0.0.2"
  s.summary      = "新建cocoapods 第一次提交，此版本只是添加文件，不可使用"

  s.description  = <<-DESC
			简单测试，项目不能运行，严禁使用。
                   DESC

  s.homepage     = "https://github.com/hsdji/testPersionalcocoapods"
  

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }




  s.author             = { "单小飞" => "2530101715@qq.com" }
  s.source           = {:git => 'https://github.com/hsdji/testPersionalcocoapods.git', :tag => s.version}
  s.requires_arc = true
  s.source_files = 'test01/*.h'


	
  s.platform     = :ios, "9.0"
end

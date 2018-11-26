

Pod::Spec.new do |s|
  s.name         = "testPersionalcocoapods"
  s.version      = "0.0.3"
  s.summary      = "网络请求封装(基于AFNnetWorking)
			1.post
			2.get
			3.delegate
			4.pull
			5.put
			.............."

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
  spec.dependency = "AFNnetWorking"

	
  s.platform     = :ios, "9.0"
end

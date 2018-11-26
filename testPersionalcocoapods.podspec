

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
			网络请求封装(基于AFNnetWorking)
				1.post
				2.get
				3.delegate
				4.pull
				5.put
				..............
                   DESC

  s.homepage     = "https://github.com/hsdji/testPersionalcocoapods"
  s.license      = "MIT"
  s.author             = { "单小飞" => "2530101715@qq.com" }
  s.source           = {:git => 'https://github.com/hsdji/testPersionalcocoapods.git', :tag => s.version}
  s.platform     = :ios, "9.0"

  s.source_files = 'test/*.*' #资源文件

  s.public_header_files = 'testPersionalcocoapods/test/*.h #公开文件

  
  s.dependency 'AFNetworking'

end

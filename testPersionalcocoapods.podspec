
Pod::Spec.new do |s|
  s.name         = "testPersionalcocoapods"
  s.version      = "V0.0.5"
  s.summary      = "网络请求封装(基于AFNnetWorking)\n
			1.post\n
			2.get \n
			3.delegate \n
			4.pull \n
			5.put \n
			..............\n
		SD"

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

  s.dependency 'AFNetworking', '~> 2.3'

  s.source_files = 'test/*.{h,m}','Pods'
  

  
 
end
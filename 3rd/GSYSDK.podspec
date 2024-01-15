Pod::Spec.new do |spec|
  spec.name         = "GSYSDK"
  spec.version      = "1.0.1"
  spec.summary      = "flutter module framework"
  spec.description  = <<-DESC
                     GSYSDK
                   DESC
  spec.homepage     = "http://EXAMPLE/FlutterFramewok"
  spec.license      =  { :type => 'MIT', :file => 'LICENSE' }
  spec.author           = { 'lxthyme' => '1094426094@qq.com' }
  spec.platform     = :ios, "11.0"
  spec.source       = { :git => 'https://github.com/lxthyme/LXToolKit.git', :tag => "v#{spec.version.to_s}" }
  spec.requires_arc          = true
  spec.default_subspec = 'Release'

  spec.subspec 'Debug' do |sub|
    sub.vendored_frameworks   = 'gsy_app/Debug/*.xcframework'
  end
  spec.subspec 'Profile' do |sub|
    sub.vendored_frameworks   = 'gsy_app/Profile/*.xcframework'
  end
  spec.subspec 'Release' do |sub|
    sub.vendored_frameworks   = 'gsy_app/Release/*.xcframework'
  end
end

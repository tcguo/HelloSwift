# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'
 inhibit_all_warnings!


source 'https://github.com/CocoaPods/Specs.git'

#source 'git@git.corp.kuaishou.com:hanzhongchao/dependents.git'
#source 'git@git.corp.kuaishou.com:ios/dependents.git'
#source 'git@git.corp.kuaishou.com:im_cloud/ios/KwaiIMFramework.git'
#source 'git@git.corp.kuaishou.com:iMV/ios-repo.git'
#source 'git@git.corp.kuaishou.com:incubation_app/500w_ios_modules/500w_repo.git'
#source 'git@git.corp.kuaishou.com:incubation_app/fh_ios_modules/fh_repo.git'
#source 'git@git.corp.kuaishou.com:lib-iOS/repo.git'
#source 'https://kcache.corp.kuaishou.com/KeepSpecs/keep_spec.git'

#use_frameworks!

#flutter
#flutter_application_path = '../my_flutter'
#load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')


def common_swift
  #网络库
  pod 'Moya/RxSwift', '14.0.0'
  pod 'Alamofire', '5.4.1'
  
  pod "PromiseKit", "~> 6.8"
  
  #Rx
  pod 'RxSwift'
  pod 'RxRelay'
  pod 'RxCocoa'
  
  pod 'RxDataSources'
  pod 'Differentiator'
  
  pod 'NSObject+Rx'
 
  #布局
  pod 'PinLayout'
  pod 'FlexLayout'
  pod 'SnapKit'
  
  #字体颜色
#  pod 'R.swift.Library'
#  pod 'R.swift'
  pod 'AnyCodable-FlightSchool'

  pod 'DeviceKit', '4.2.1'
 
 #页面手势
  pod 'RxGesture', '3.0.0'
  pod 'SwifterSwift',  '5.2.0'
  pod 'RxOptional', '4.1.0'
  pod 'WeakMapTable', '1.1.0'
  pod 'ReactorKit',  '2.1.0'
  
  #转场动画
  pod 'Hero'
  pod 'Disk'
  pod 'JXPagingView', :subspecs=>['Paging']
  pod 'JXSegmentedView', '1.2.7'
  pod 'PermissionKit'
  pod 'Toast-Swift', '5.0.1'
  pod 'Kingfisher', '5.15.8'
  pod 'XCGLogger', '7.0.1'
  pod 'ObjcExceptionBridging', '1.0.1', :modular_headers => true
  pod 'Tiercel', '3.2.0'
  pod 'RxReachability' , '1.0.0'
  pod 'ReachabilitySwift', '4.3.1'
  pod 'AssociatedValues',  '5.0.0'
#  pod 'AgoraRtcEngine_iOS', '3.4.6', :modular_headers => true
end

def tools
  pod 'NVActivityIndicatorView'
end

def third_party

  pod 'MBProgressHUD', :modular_headers => true
  ##HWPanModal https://github.com/HeathWang/HWPanModal/blob/master/README-CN.md
  #用于从底部弹出控制器（UIViewController），并用拖拽手势来关闭控制器。提供了自定义视图大小和位置，高度自定义弹出视图的各个属性。
  pod 'HWPanModal', '~> 0.9.4', :modular_headers => true
  
end

install! 'cocoapods',
      :warn_for_multiple_pod_sources => false,
      :deterministic_uuids => false,
      :disable_input_output_paths => true

target 'HelloSwift' do
  # Comment the next line if you don't want to use dynamic frameworks
#  use_frameworks!

  # 安装Flutter模块
#  install_all_flutter_pods(flutter_application_path)

  common_swift
  third_party
  tools
  pod 'LookinServer', :configurations => ['Debug']
  
#  pod 'BNCFoundation', :path => 'HelloSwift2/BinancePods/BNCFoundation'
#  pod 'BinanceCharts', :path => 'HelloSwift/BinanceCharts'
  pod 'LoggableKit', :path => 'HelloSwift/BinancePods/LoggableKit'
  pod 'BNCFoundationKit', :path => 'HelloSwift/BinancePods/BNCFoundationKit'
  pod 'Persistent', :path => 'HelloSwift/BinancePods/Persistent'
  
  
  post_install do |installer|
  flutter_post_install(installer) if defined?(flutter_post_install)
  
  installer.pod_target_subprojects.flat_map(&:targets).each do |target|
    target.build_configurations.each do |config|
#        if config.base_configuration_reference
#            xcconfig_path = config.base_configuration_reference.real_path
#            xcconfig = File.read(xcconfig_path)
            new_xcconfig = xcconfig.sub('-framework "AgoraCore"', "")
#            File.open(xcconfig_path, "w") { |file| file << new_xcconfig }
#        end
    end

  end
  end
    
  
end




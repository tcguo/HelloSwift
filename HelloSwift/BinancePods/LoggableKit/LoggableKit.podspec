Pod::Spec.new do |s|
  s.name                    = 'LoggableKit'
  s.version                 = '1.0.0'
  s.summary                 = 'Internal library for drawing time-series data.'
  s.homepage                = 'https://git.toolsfdg.net/fe/swift-binance-charts'
  s.license                 = 'All rights reserved.'
  s.author                  = { 'Binance' => 'app@binance.com' }
  s.source                  = { git: 'https://git.toolsfdg.net/fe/swift-binance-charts.git', tag: s.version.to_s }
  s.swift_version           = '5.1'

  s.ios.deployment_target   = '13.0'
  s.ios.source_files        = 'LoggableKit/Classes/**/*.swift'
  
end

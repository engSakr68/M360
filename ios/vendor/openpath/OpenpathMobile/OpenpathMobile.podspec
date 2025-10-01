# frozen_string_literal: true
Pod::Spec.new do |s|
  s.name    = 'OpenpathMobile'
  s.version = '0.5.0'
  s.summary = 'Openpath SDK.'
  s.description = 'Openpath SDK library.'
  s.homepage = 'https://openpath.com'
  s.license  = { type: 'All rights reserved', file: 'LICENSE' }
  s.author   = 'Openpath'

  s.ios.deployment_target = '15.0'
  s.swift_versions = '5'
  s.static_framework = true

  # Local placeholder source so CocoaPods doesn’t try to fetch from network
  s.source = { :http => 'file://' + File.expand_path('.', __dir__) }

  s.vendored_frameworks = 'OpenpathMobile.xcframework'

  s.dependency 'OpenSSL-Universal', '1.1.2301'
  s.dependency 'AWSCore', '2.37.2'
  s.dependency 'AWSIoT',  '2.37.2'
  s.dependency 'AWSLogs', '2.37.2'

  s.pod_target_xcconfig = { 'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES' }
end

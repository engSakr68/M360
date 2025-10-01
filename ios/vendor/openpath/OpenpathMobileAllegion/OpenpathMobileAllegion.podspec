# frozen_string_literal: true
Pod::Spec.new do |s|
  s.name    = 'OpenpathMobileAllegion'
  s.version = '0.5.0'
  s.summary = 'Allegion support for Openpath SDK.'
  s.description = 'Allegion support for Openpath SDK.'
  s.homepage = 'https://openpath.com'
  s.license  = { type: 'All rights reserved', file: 'LICENSE' }
  s.author   = 'Openpath'

  s.ios.deployment_target = '15.0'
  s.swift_versions = '5'
  s.static_framework = true

  s.source = { :http => 'file://' + File.expand_path('.', __dir__) }

  s.vendored_frameworks = %w[
    AllegionAccessBLECredential.xcframework
    AllegionAccessHub.xcframework
    AllegionAnalytics.xcframework
    AllegionBLECore.xcframework
    AllegionExtensions.xcframework
    AllegionLogging.xcframework
    AllegionSecurity.xcframework
    AllegionTranslation.xcframework
    Allegion_Access_MobileAccessSDK_iOS.xcframework
    OpenpathMobileAllegion.xcframework
  ]

  s.dependency 'PromiseKit',        '~> 8.0'
  s.dependency 'AmplitudeSwift',    '~> 1.11'
  s.dependency 'Analytics',         '~> 4.1'
  s.dependency 'CryptoSwift',       '~> 1.0'
  s.dependency 'IOSSecuritySuite',  '~> 2.0'
  s.dependency 'SwiftCBOR',         '= 0.4.5'
  s.dependency 'OpenpathMobile',    s.version.version
  s.dependency 'OpenSSL-Universal', '1.1.2301'
end

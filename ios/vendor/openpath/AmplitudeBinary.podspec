Pod::Spec.new do |s|
  s.name     = 'AmplitudeBinary'
  s.version  = '1.6.0' # use the version you actually have
  s.summary  = 'Amplitude Swift + Core as local xcframeworks'
  s.homepage = 'https://amplitude.com'
  s.license  = { :type => 'Proprietary', :text => 'See Amplitude license' }
  s.author   = { 'Amplitude' => 'support@amplitude.com' }
  s.platform = :ios, '13.0'
  s.source   = { :path => '.' }

  # Vend both frameworks so CocoaPods embeds them in Runner.app/Frameworks
  s.vendored_frameworks = [
    'AmplitudeSwift.xcframework',
    'AmplitudeCore.xcframework'
  ]

  # Ensure they’re treated as dynamic (so they get embedded)
  s.static_framework = false
end

def test_pods
    pod 'Expecta', '~> 0.3.0'
    pod 'ISO8601DateFormatterValueTransformer', :path => '.'
end

abstract_target 'Framework' do
  pod 'RKValueTransformers', '~> 1.1.0'
  pod 'ISO8601DateFormatter', '~> 0.7'

  target 'ISO8601DateFormatterValueTransformer iOS' do
    platform :ios, '6.0'
  end

  target 'ISO8601DateFormatterValueTransformer macOS' do
    platform :osx, '10.7'
  end
  
  target 'ISO8601DateFormatterValueTransformer iOS Tests' do
      platform :ios, '6.0'
      test_pods
  end
  
  target 'ISO8601DateFormatterValueTransformer macOS Tests' do
      platform :osx, '10.7'
      test_pods
  end
end

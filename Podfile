xcodeproj 'Tests/ISO8601DateFormatterValueTransformerTests'
workspace 'ISO8601DateFormatterValueTransformer'
inhibit_all_warnings!

def import_pods
  pod 'Expecta', '~> 0.2.1'
  pod 'ISO8601DateFormatterValueTransformer', :path => '.'
end

target :ios do
  platform :ios, '5.0'
  link_with 'iOS Tests'
  import_pods
end

target :osx do
  platform :osx, '10.7'
  link_with 'OS X Tests'
  import_pods
end

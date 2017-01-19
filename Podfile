# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'
# use_frameworks!

target 'GithubIssues' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GithubIssues
  
  pod 'Alamofire', '~> 4.0'
  pod 'AlamofireImage', '~> 3.1'
  
  pod 'p2.OAuth2', '~> 3.0'
  
  pod 'SwiftyJSON'
  pod 'ObjectMapper'
  
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources'
  
  pod 'FDStackView'


  target 'GithubIssuesTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'GithubIssuesUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end

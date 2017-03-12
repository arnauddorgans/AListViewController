#
# Be sure to run `pod lib lint AListViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AListViewController'
  s.version          = '0.1.0'
  s.summary          = 'Elegant UITableViewController/UICollectionViewController in Swift.'

  s.homepage         = 'https://github.com/Arnoymous/AListViewController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Arnaud Dorgans' => 'arnaud.dorgans@gmail.com' }
  s.source           = { :git => 'https://github.com/Arnoymous/AListViewController.git', :tag => s.version }
  s.social_media_url = 'https://twitter.com/arnauddorgans'

  s.requires_arc	= true
  s.default_subspec = 'Base'

  s.subspec 'Base' do |lite|
    lite.platforms = { :ios => "8.0", :tvos => "9.0" }
    lite.source_files = 'AListViewController/Classes/**/*'
  end

  s.subspec 'PullToRefresh' do |pull|
    pull.platforms = { :ios => "8.0" }
    pull.dependency	'ESPullToRefresh', '~> 2.6'
    pull.xcconfig	=
    { 'OTHER_SWIFT_FLAGS' => '$(inherited) -DALISTVIEWCONTROLLER_PULL' }
  end

  s.subspec 'InfiniteScrolling' do |pull|
    pull.platforms = { :ios => "8.0" }
    pull.dependency	'ESPullToRefresh', '~> 2.6'
    pull.xcconfig	=
    { 'OTHER_SWIFT_FLAGS' => '$(inherited) -DALISTVIEWCONTROLLER_INFINITESCROLLING' }
  end

end


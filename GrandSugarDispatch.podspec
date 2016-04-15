Pod::Spec.new do |s|
   s.name = 'GrandSugarDispatch'
   s.version = '1.0.0'
   s.license = 'MIT'

   s.summary = 'Syntactic sugar for Grand Central Dispatch (GCD)'
   s.homepage = 'https://github.com/jessesquires/GrandSugarDispatch'
   s.documentation_url = 'http://www.jessesquires.com/GrandSugarDispatch/'
   s.social_media_url = 'https://twitter.com/jesse_squires'
   s.author = 'Jesse Squires'

   s.source = { :git => 'https://github.com/jessesquires/GrandSugarDispatch.git', :tag => s.version }
   s.source_files = 'Source/*.swift'

   s.ios.deployment_target = '8.0'
   s.osx.deployment_target = '10.10'
   s.tvos.deployment_target = '9.0'
   s.watchos.deployment_target = '2.0'

   s.requires_arc = true
end

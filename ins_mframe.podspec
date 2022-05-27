#
#  Be sure to run `pod spec lint ins_mframe.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "ins_mframe"
  spec.version      = "1.0.7"
  spec.summary      = "include moduledframe, moduleH5, moduleUI, moduleUser framework"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  spec.description  = <<-DESC
  
  moduledframe: Swift网络库，用法如下：
    
    初始化
    let ret = INS_RetrofitUtil.initWithKey("12345678", baseURL: URL.init(string: "https://uat-jk.jlflove.com")!, enableLog: true, parseEngine: nil)


    发送单个请求
    INS_RetrofitUtil
            .create(serviceClass: LoginService.self)
            .loginRequest(params)
            .subscribe(on: .instance)
            .observe(on: .asyncInstance)
            .onResult { result, err in
                
            }
    //2个请求串发， 请求的返回model可以不一致
    let req3 = INS_RetrofitUtil
            .create(serviceClass: LoginService.self)
            .loginRequest(params)
            .subscribe(on: .instance)
            .observe(on: .asyncInstance)

        req3.compat { loginModel, err -> INS_Observable<BaseResult<InfoModel>> in
            let req4 = INS_RetrofitUtil
                .create(serviceClass: LoginService.self)
                .loginRequest2(params)
                .subscribe(on: .instance)
                .observe(on: .asyncInstance)
            return req4
        } resultHandler: { login2Model, err in
           
        }

    自定义请求
    class LoginService: INS_ApiCourseService {
            func loginRequest(_ param: Dictionary<String, String>) -> INS_Observable<PlainResult> {
            let req = INS_RequestBuilder.create()
                .setURL(URL.init(string: "https://uat-jk.jlflove.com")!)
                .setPath("flove/user/login")
                .setHttpMethod(.post)
                .setBodyParameters(param)
                .builder()
            return Self.loadRequest(req)
        }
                   DESC

  spec.homepage     = "https://github.com/FicentAlanZeng/ins_mframe"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  spec.license      = "MIT"
  # spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  spec.author             = { "Alan" => "876224031@qq.com" }
  # Or just: spec.author    = "Alan"
  # spec.authors            = { "Alan" => "876224031@qq.com" }
  # spec.social_media_url   = "https://twitter.com/Alan"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # spec.platform     = :ios
  spec.platform     = :ios, "12.0"
  spec.swift_versions = "5.0"
  spec.pod_target_xcconfig = { 'VALID_ARCHS' => 'x86_64 armv7 armv7s arm64' }

  #  When using multiple platforms
  spec.ios.deployment_target = "12.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  spec.source       = { :git => "https://github.com/FicentAlanZeng/ins_mframe.git", :tag => "v#{spec.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  # spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  # spec.exclude_files = "Classes/Exclude"

  # spec.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #
  
  spec.vendored_frameworks = "Source/*.framework"
  spec.frameworks = "UIKit", "Foundation"
  
  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  
  spec.dependency "Alamofire", "~> 5.6.1"
  spec.dependency "Moya/RxSwift", "~> 15.0.0"
  spec.dependency "ObjectMapper", "~> 4.2.0"
  spec.dependency "RxSwift", "~> 6.2.0"
  spec.dependency "SnapKit", "~> 5.6.0"

end

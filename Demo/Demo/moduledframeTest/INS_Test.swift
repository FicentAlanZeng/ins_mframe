//
//  INS_Test.swift
//  dframe
//
//  Created by Alan on 2022/4/18.
//

import Foundation
import RxSwift
import ObjectMapper
import moduledframe

/// Demo
/// 针对数据格式为
///  {
///  "code" : 40021,
///  "message" : "验证码不存在或已过期，请重新获取验证码",
///  "data" : null
///  } 解析，
///
///
///

// 最外层解析
fileprivate class INS_Test_TopBaseResult: INS_SuperModel {
    open var code: String?
    open var msg: String?
    
    
    public override func mapping(map: INS_Map) {
        super.mapping(map: map)
        code <- (map["code"], INS_SafeStringTransform())
        msg  <- map["msg"]
    }

    
    func isOk() -> Bool {
        return self.code == "200"
    }
}

// data 是个字符串
fileprivate class INS_Test_PlainResult: INS_Test_TopBaseResult {
    open var data: String?
    public override func mapping(map: Map) {
        super.mapping(map: map)
        data <- (map["data"], INS_SafeStringTransform())
    }
}

// data 是个字典，需要解析成对象T
fileprivate class INS_Test_BaseResult<T: INS_SuperModel>: INS_Test_TopBaseResult {
    open var data: T?
    public override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}

// data 内容是个字典，以字典形式存在
fileprivate class INS_Test_BaseDictionaryResult: INS_Test_TopBaseResult {
    open var data: Dictionary<String, Any>?
    public override func mapping(map: Map) {
        super.mapping(map: map)
        data <- (map["data"], INS_SafeDicTransform())
    }
}


// data 内容是个对象数组
fileprivate class INS_Test_BaseListResult<T: INS_SuperModel>: INS_Test_TopBaseResult {
    open var data: [T]?
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}

// data 内容是个String数组
fileprivate class INS_Test_BaseListStringResult<T: StringProtocol>: INS_Test_TopBaseResult {
    open var data: [T]?
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}



// data内部是个分页的内容 INS_Test_BaseResult<INS_Test_BasePageModel<T>>
fileprivate class INS_Test_BasePageModel<T: INS_SuperModel>: INS_Test_TopBaseResult {
    open var pageSize: Int?
    open var page: Int?
    open var pageCount: Int?
    open var totalCount: Int?
    open var list: [T]?
    public override func mapping(map: Map) {
        super.mapping(map: map)
        pageSize <- map["size"]
        page <- map["current"]
        pageCount <- map["pages"]
        totalCount <- map["total"]
        list <- map["items"]
    }
}



// 最内层的Model，不再以范型的形式呈现
fileprivate class INS_Test_InfoModel: INS_SuperModel {
    var hxpassword: String?
    var token: String?
    var hxusername: String?
    var verifyInfo: Bool?
    public override func mapping(map: Map) {
        super.mapping(map: map)
        token <- map["token"]
        hxpassword <- map["password"]
        hxusername <- map["username"]
        verifyInfo <- (map["verifyInfo"], INS_SafeBoolTransform())
    }
    
}

fileprivate class INS_Test_LoginModel: INS_SuperModel {
 
    
}



//生成请求方案一，直接继承INS_IXRequest, 此写法不方便传递参数， 丢弃
/*
public class LoginRequest: INS_IXRequest {
    public func ins_baseURL() -> URL? {
        return URL.init(string: "https://uat-jk.jlflove.com")!
    }
    
    public func ins_path() -> String {
        return "flove/user/login"
    }
    
    public func ins_httpMethod() -> INS_HTTP_Method {
        return .post
    }
    
    public func ins_headerFields() -> Dictionary<String, String>? {
        return nil
    }
    
    public func ins_bodyParameters() -> Dictionary<String, String>? {
        var params: [String: String] = [:]
        params["mobile"] = "18662121205"
        params["code"] = "1234"
        return params
    }
    
    public func ins_formDatas() -> [INS_MultipartFormData]? {
        return nil
    }
}
 */

//生成请求方案二，通过Build器去生成


//接口，按模块划分
fileprivate class TestLoginService: INS_ApiCourseService {
    func loginRequest(_ param: Dictionary<String, Any>) -> INS_Observable<INS_Test_PlainResult> {
        let req = INS_RequestBuilder.create()
            .setURL(URL.init(string: "https://uat-jk.jlflove.com")!)
            .setPath("flove/user/login")
            .setHttpMethod(.post)
            .setBodyParameters(param)
            .builder()
        return Self.loadRequest(req)
    }
    
    func loginRequest2(_ param: Dictionary<String, Any>) -> INS_Observable<INS_Test_BaseResult<INS_Test_InfoModel>> {
//        let req = LoginRequest.init()
        // 上传图片文件
        let req = INS_RequestBuilder.create()
            .setURL(URL.init(string: "https://uat-jk.jlflove.com")!)
            .setPath("flove/user/login")
            .setHttpMethod(.post)
            .setBodyParameters(param)
            .setUrlParameters(["a": "哈哈哈"])
        //图片上传需要下面参数
//            .setFormDatas([INS_MultipartFormData(data: Data.init(), name: "", fileName: "", mimeType: "mime/jpeg")])
            .builder()
        return Self.loadRequest(req)
    }
}



class Test {
    // APP 启动需要执行一次，才能调用接口
    class func initINS() {
        let ret = INS_RetrofitUtil.initWithKey("12345678", baseURL: URL.init(string: "https://uat-jk.jlflove.com")!, enableLog: true, parseEngine: nil)
//        let ret = INS_RetrofitUtil.initWithKey("12345678", baseURL: URL.init(string: "https://uat-jk.jlflove.com")!)
        if !ret {
            return
        }
    }
    
    class func test(_ disposeBag: DisposeBag? = nil) {
        Self.initINS() //初始化 只需执行一次
//        let req1 = INS_RetrofitUtil
//            .create(serviceClass: TestLoginService.self)
//            .loginRequest([:])
//            .subscribe(on: .instance)
//            .observe(on: .asyncInstance)
//
//        req1.onResult(handler: { a, err in
//
//        })
//
//
//        let req2 = INS_RetrofitUtil
//            .create(serviceClass: TestLoginService.self)
//            .loginRequest([:])
//            .subscribe(on: .instance)
//            .observe(on: .asyncInstance)
//
//        req2.onResult(handler: { a, err in
//
//        })
     
        
//
        var params: [String: Any] = [:]
        params["mobile"] = "18662121205"
        params["code"] = "1234"
        params["a"] = 1
        let req3 = INS_RetrofitUtil
            .create(serviceClass: TestLoginService.self)
            .loginRequest2(params)
            .subscribe(on: .instance)
            .observe(on: .asyncInstance)

        req3.onResult { a, err in
            print("+++++++++++")
            print(a?.msg ?? "")
            print("+++++++++++")
        }
//
//
//
//        //2个请求串发， 请求的返回model可以不一致
//        req3.compat { INS_Test_LoginModel, err -> INS_Observable<INS_Test_BaseResult<INS_Test_InfoModel>> in
//            let req4 = INS_RetrofitUtil
//                .create(serviceClass: LoginService.self)
//                .loginRequest2(params)
//                .subscribe(on: .instance)
//                .observe(on: .asyncInstance)
//            return req4
//        } resultHandler: { login2Model, err in
//
//            print(login2Model?.data?.hxusername)
//        }
        
        ///多个请求串发，需要返回结果一致，待封装  同一个接口调用多次可能用到，比如上传9张图片，每次上传一张
        ///类似Observable<INS_Test_PlainResult>.concat(AnySequence(all)).subscribeOn(MainScheduler.asyncInstance).subscribe
        
        
        ///并发多个接口，结果都回来以后再统一处理逻辑，比如用户是否在对方的
        
        
    }
}




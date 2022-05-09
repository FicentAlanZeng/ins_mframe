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
public class INS_TopBaseResult: INS_SuperModel {
    open var code: String?
    open var msg: String?
    
    
    public override func mapping(map: INS_Map) {
        super.mapping(map: map)
        code <- (map["code"], INS_SafeStringTransform())
        msg  <- map["message"]
    }

    
    func isOk() -> Bool {
        return self.code == "200"
    }
}

// data 是个字符串
public class PlainResult: INS_TopBaseResult {
    open var data: String?
    public override func mapping(map: Map) {
        super.mapping(map: map)
        data <- (map["data"], INS_SafeStringTransform())
    }
}

// data 是个字典，需要解析成对象T
public class BaseResult<T: INS_SuperModel>: INS_TopBaseResult {
    open var data: T?
    public override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}

// data 内容是个字典，以字典形式存在
public class BaseDictionaryResult: INS_TopBaseResult {
    open var data: Dictionary<String, Any>?
    public override func mapping(map: Map) {
        super.mapping(map: map)
        data <- (map["data"], INS_SafeDicTransform())
    }
}


// data 内容是个对象数组
public class BaseListResult<T: INS_SuperModel>: INS_TopBaseResult {
    open var data: [T]?
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}

// data 内容是个String数组
public class BaseListStringResult<T: StringProtocol>: INS_TopBaseResult {
    open var data: [T]?
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}



// data内部是个分页的内容 BaseResult<BasePageModel<T>>
public class BasePageModel<T: INS_SuperModel>: INS_TopBaseResult {
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
public class InfoModel: INS_SuperModel {
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

public class LoginModel: INS_SuperModel {
 
    
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
    
    func loginRequest2(_ param: Dictionary<String, String>) -> INS_Observable<BaseResult<InfoModel>> {
//        let req = LoginRequest.init()
        let req = INS_RequestBuilder.create()
            .setURL(URL.init(string: "https://uat-jk.jlflove.com")!)
            .setPath("flove/user/login")
            .setHttpMethod(.post)
            .setBodyParameters(param)
            .builder()
        return Self.loadRequest(req)
    }
}

class Test {
    class func test(_ disposeBag: DisposeBag? = nil) {
        let ret = INS_RetrofitUtil.initWithKey("12345678", baseURL: URL.init(string: "https://uat-jk.jlflove.com")!, enableLog: true, parseEngine: nil)
//        let ret = INS_RetrofitUtil.initWithKey("12345678", baseURL: URL.init(string: "https://uat-jk.jlflove.com")!)
        if !ret {
            return
        }
//        let req1 = INS_RetrofitUtil
//            .create(serviceClass: LoginService.self)
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
//            .create(serviceClass: LoginService.self)
//            .loginRequest([:])
//            .subscribe(on: .instance)
//            .observe(on: .asyncInstance)
//        
//        req2.onResult(handler: { a, err in
//            
//        })
        
        var params: [String: String] = [:]
        params["mobile"] = "18662121205"
        params["code"] = "1234"

        let req3 = INS_RetrofitUtil
            .create(serviceClass: LoginService.self)
            .loginRequest(params)
            .subscribe(on: .instance)
            .observe(on: .asyncInstance)
           
        
        //2个请求串发， 请求的返回model可以不一致
        req3.compat { loginModel, err -> INS_Observable<BaseResult<InfoModel>> in
            let req4 = INS_RetrofitUtil
                .create(serviceClass: LoginService.self)
                .loginRequest2(params)
                .subscribe(on: .instance)
                .observe(on: .asyncInstance)
            return req4
        } resultHandler: { login2Model, err in
           
        }
        
        ///多个请求串发，需要返回结果一致，待封装  同一个接口调用多次可能用到，比如上传9张图片，每次上传一张
        ///类似Observable<PlainResult>.concat(AnySequence(all)).subscribeOn(MainScheduler.asyncInstance).subscribe
        
        
        ///并发多个接口，结果都回来以后再统一处理逻辑，比如用户是否在对方的
        
        
    }
}




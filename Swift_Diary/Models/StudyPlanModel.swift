//
//  StudyPlanModel.swift
//  Swift_Diary
//
//  Created by 24hmb on 2017/1/3.
//  Copyright © 2017年 24hmb. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

struct URLSessionClient: Client {
    let host = "http://117.144.157.4:8080/24/web/study/"
    
    internal func send<T : CCRequest>(_ r: T, handler: @escaping ([T.Response?], Error?) -> Void) {
        let url = URL(string: host.appending(r.path))!
        var request = URLRequest(url: url)
        request.httpMethod = r.method.rawValue
        let bodyStr: String = getHttpBodyString(r.parameter)
        request.httpBody = bodyStr.data(using: .utf8)
        request.timeoutInterval = 10.0
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let data = data, let res: [T.Response?] = r.parse(data: data) {
                DispatchQueue.main.async { handler(res, error) }
            } else {
                NSLog("error === \(error)")
                DispatchQueue.main.async { handler([], error) }
            }
        }
        task.resume()
    }
    
    internal func alamofireSend<T : CCRequest>(_ r: T, handler: @escaping ([T.Response?], Error?) -> Void) {
        let url = URL(string: host.appending(r.path))!
        Alamofire.request(url, method: .post, parameters: r.parameter).responseJSON { (response) in
            debugPrint("data === \(response.data)")
            if response.result.isSuccess {
                let value = JSON(response.result.value!)
                debugPrint("value ==== \(value)")
                if let res = r.JSONParse(jsonData: value["data"]) {
                    DispatchQueue.main.async { handler(res, response.result.error) }
                }
            }else {
                NSLog("error === \(response.result.error)")
                DispatchQueue.main.async { handler([], response.result.error) }
            }
        }
    }
}

struct StudyPlanModelRequest: CCRequest {
    
    // 配置请求的基本参数
    let path: String = "queryStudyList"
    let method: HTTPMethod = .POST
    let parameter: [String: Any]
    
    typealias Response = StudyPlanModel
    
    /// 返回一个model数组，适用于列表显示
    internal func parse(data: Data) -> [Response?]? {
        var dataArray: [StudyPlanModel?] = []
        if let dic1 = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Any] {
            let arr = dic1["data"] as! Array<Any>
            NSLog("arr === \(arr)")
            for dic in arr {
                let model = StudyPlanModel.init(data: try! JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted))
                dataArray.append(model)
            }
            return dataArray
        }else {
            return dataArray
        }
    }
    /// 返回一个model
    internal func parse(data: Data) -> Response? {
        return nil
    }
    
    /// 使用SwiftyJSON 进行解析 返回一个model数组，适用于列表显示
    internal func JSONParse(jsonData: JSON) -> [Response?]? {
        var dataArr: [StudyPlanModel?] = []
        let arr = jsonData.array
        for dic in arr! {
            let model = StudyPlanModel.init(dictionary: dic)
            dataArr.append(model)
        }
        return dataArr
    }
}

private func getHttpBodyString(_ parameters: [String: Any]) ->String {
    var list = Array<String>()
    for subDic in parameters {
        let tmpStr = "\(subDic.0)=\(subDic.1)"
        list.append(tmpStr)
    }
    //用&拼接变成字符串的字典各项
    let paramStr = list.joined(separator: "&")
    return paramStr
}

struct StudyPlanModel: Decodable {
    /// 返回一个model
    internal func parse(data: Data) -> StudyPlanModel? {
        return StudyPlanModel(data: data)
    }

    var planName: String
    var finishCount: Int
    var allCount: Int
    var startTime: String
    var endTime: String
    var studyPlanId: Int

    ///传入data 得到一个StudyPlanModel，前提是value不为空，否则会返回nil
    init?(data: Data) {
        
        guard let obj = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
            return nil
        }
        guard let planName = obj?["planName"] as? String else {
            return nil
        }
        guard let finishCount = obj?["finishCount"] as? Int else {
            return nil
        }
        guard let allCount = obj?["allCount"] as? Int else {
            return nil
        }
        guard let startTime = obj?["startTime"] as? String else {
            return nil
        }
        guard let endTime = obj?["endTime"] as? String else {
            return nil
        }
        guard let studyPlanId = obj?["studyPlanId"] as? Int else {
            return nil
        }
        self.planName = planName
        self.finishCount = finishCount
        self.allCount = allCount
        self.startTime = startTime.replacingOccurrences(of: "-", with: ".")
        self.endTime = endTime.replacingOccurrences(of: "-", with: ".")
        self.studyPlanId = studyPlanId
    }
    
    init(dictionary: JSON?) {
        self.planName = (dictionary?["planName"].string)!
        self.finishCount = (dictionary?["finishCount"].int)!
        self.allCount = (dictionary?["allCount"].int)!
        self.startTime = (dictionary?["startTime"].string)!.replacingOccurrences(of: "-", with: ".")
        self.endTime = (dictionary?["endTime"].string)!.replacingOccurrences(of: "-", with: ".")
        self.studyPlanId = (dictionary?["studyPlanId"].int)!
    }
}

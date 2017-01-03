//
//  StudyPlanModel.swift
//  Swift_Diary
//
//  Created by 24hmb on 2017/1/3.
//  Copyright © 2017年 24hmb. All rights reserved.
//

import Foundation
import SwiftyJSON

struct StudyPlanModelRequest: CCRequest {
    
    // 配置请求的基本参数
    let host = "http://117.144.157.4:8080/24/web/study/"
    let path: String = "queryStudyList"
    let method: HTTPMethod = .POST
    let parameter: [String: Any]
    
    typealias Response = StudyPlanModel
    
    /// 返回一个model数组，适用于列表显示
    internal func parse(data: Data) -> [Response?]? {
        var dataArray: [StudyPlanModel?] = []
        if let arr = try? JSONSerialization.jsonObject(with: data, options: []) as! Array<Any> {
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
}

extension StudyPlanModelRequest {
    func send(handler: @escaping([Response?], Error?) -> Void) {
        let url = URL(string: host.appending(path))!
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        let bodyStr: String = getHttpBodyString(parameter)
        request.httpBody = bodyStr.data(using: .utf8)
        request.timeoutInterval = 10.0
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let data = data, let res: [Response?] = self.parse(data: data) {
                DispatchQueue.main.async { handler(res, error) }
            } else {
                NSLog("error === \(error)")
                DispatchQueue.main.async { handler([], error) }
            }
        }
        task.resume()
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


struct StudyPlanModel {
    var planName: String
    var finishCount: Int
    var allCount: Int
    var startTime: String
    var endTime: String
    var studyPlanId: Int
    
//    init(json: JSON) {
//        
//    }
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
}

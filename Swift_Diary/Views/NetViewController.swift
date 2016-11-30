//
//  AFNetViewController.swift
//  Swift_Diary
//
//  Created by 24hmb on 2016/11/16.
//  Copyright © 2016年 24hmb. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NetViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "NetWorking_demo"
        // Do any additional setup after loading the view.
        
//        let parameters = ["key":333]
        
        let getButton = UIButton.init(type: .system)
        
        let postButton = UIButton.init(type: .system)
        
        let uploadButton = UIButton(type: .system)
        
        
        getButton.setTitle("HTTP GET", for: .normal)
        getButton.tag = 101
        postButton.setTitle("HTTP POST", for: .normal)
        postButton.tag = 102
        uploadButton.setTitle("HTTP Upload", for: .normal)
        uploadButton.tag = 103
        
        self.view.addSubview(getButton)
        self.view.addSubview(postButton)
        self.view.addSubview(uploadButton)
        
        getButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(200)
        }
        
        postButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(getButton.snp.bottom).offset(50)
        }
        
        uploadButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(postButton.snp.bottom).offset(50)
        }
        
        getButton.addTarget(self, action: #selector(httpGetOrPostRequest(button:)), for: .touchUpInside)
        postButton.addTarget(self, action: #selector(httpGetOrPostRequest(button:)), for: .touchUpInside)
        uploadButton.addTarget(self, action: #selector(httpGetOrPostRequest(button:)), for: .touchUpInside)
    }

    /// get 请求
    private func getNetRequest(parameters: Parameters) {
        Alamofire.request("http://meetliveapi.24hmb.com/api/GetBanner", parameters: parameters).responseString(completionHandler: { (responseString) in
            //debugPrint("responseString Info : \(responseString)")
        }) .responseJSON { (response) in
            debugPrint(response.request!)  // original URL request
            debugPrint(response.response!) // HTTP URL response
            debugPrint(response.data!)     // server data
            debugPrint(response.result)   // result of response serialization
            
            //debugPrint("All Response Info: \(response)")
            
            if let JSON = response.result.value {
                debugPrint("JSON: \(JSON)")
            }
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                debugPrint("Data: \(utf8Text)")
            }
            if response.result.isSuccess {
                let value = JSON(response.result.value as Any)
                debugPrint("value ==== \(value)")
                if let title = value["data"][0]["bn_title"].string {
                    //可以直接解析到title中，不用考虑数组过界和类型不符合的问题
                    debugPrint("title === \(title)")
                }
            }
        }
    }
    
    private func postNetRequest(parameters: Parameters) {
        Alamofire.request("http://meetliveapi.24hmb.com/api/GetAreaList", method: .post, parameters: parameters).responseJSON { (jsonData) in
            debugPrint(jsonData.request!)  // original URL request
            debugPrint(jsonData.response!) // HTTP URL response
            debugPrint(jsonData.data!)     // server data
            debugPrint(jsonData.result)   // result of response serialization
            
            //debugPrint("All Response Info: \(response)")
            
            if let JSON = jsonData.result.value {
                debugPrint("JSON: \(JSON)")
            }
            if let data = jsonData.data, let utf8Text = String(data: data, encoding: .utf8) {
                debugPrint("Data: \(utf8Text)")
            }
        }
    }
    
    func httpGetOrPostRequest(button: UIButton) {
        debugPrint(button)
        switch button.tag {
        case 101:
            debugPrint("http get request")
            self.getNetRequest(parameters: Parameters())
            break
        case 102:
            debugPrint("http post request")
            self.postNetRequest(parameters: Parameters())
            break
        case 103:
            debugPrint("http upload request")
            self.uploadImage()
            break
        default:
            break
        }
    }
    
    private func uploadImage() {
        let imagePicker = UIImagePickerController.init()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        debugPrint(info)
        let image = info[UIImagePickerControllerEditedImage] as? UIImage
        try! self.httpLoadImage(image)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func httpLoadImage(_ image: UIImage?) throws {
        if image == nil {
            throw PrinterError.NoToner
        }
        //用于上传data数据
//        Alamofire.upload(UIImagePNGRepresentation(image!)!, to: "http://meetliveapi.24hmb.com/api/ImageUpload").uploadProgress { (progress) in
//            debugPrint("progress === \(progress)")
//            }.responseJSON { (response) in
//                debugPrint("response === \(response)")
//                if response.result.isSuccess {
//                    debugPrint(response.request!)  // original URL request
//                    debugPrint(response.response!) // HTTP URL response
//                    debugPrint(response.data!)     // server data
//                    debugPrint(response.result)   // result of response serialization
//                    self.dismiss(animated: true , completion: nil)
//                } else {
//                    //throw PrinterError.NoToner
//                }
//        }
        
        //上传图片以及 多文件上传
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(UIImagePNGRepresentation(image!)!, withName: "imageFile", fileName: "222.png", mimeType: "png/jgp")
        }, to: URL.init(string: "http://meetliveapi.24hmb.com/api/ImageUpload")!, encodingCompletion: {
            (result) in
            debugPrint("result === \(result)");
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        let json = JSON(value)
                        //上传成功 并解析upload ：UploadRequest的数据。以及image的地址
                        debugPrint(json["data"].string!)
                    }
                }
            case .failure(let encodingError):
                debugPrint(encodingError)
                break
                
            }
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

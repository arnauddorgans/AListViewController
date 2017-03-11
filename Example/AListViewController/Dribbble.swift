//
//  Dribbble.swift
//  AListViewController
//
//  Created by Arnaud Dorgans on 03/10/2017.
//  Copyright © 2017 Arnaud Dorgans. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

private let serviceURL = "https://api.dribbble.com/v1/"
private let token = "52152818cb68e7075b4ac1a75ca97415d9f421aa8794c47acd5778c3cd10bf1d"

private let userID = "1"

class DribbbleShot: Mappable {
    var id: Int!
    var title: String!
    var description: String!
    var width: CGFloat!
    var height: CGFloat!
    var heightRatio: CGFloat {
        return height / width
    }
    var image: URL!
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        description <- map["description"]
        width <- map["width"]
        height <- map["height"]
        image <- (map["images.normal"],URLTransform())
    }
    
    static func get(fromUserID id: String = userID,atPage page: Int = 1,perPage:Int = 30,completion:@escaping (Bool,[DribbbleShot],Bool)->Void) {
        let url = serviceURL + "/users/\(id)/shots?access_token=\(token)&page=\(page)&per_page=\(perPage)"
        Alamofire.SessionManager.default.request(url, method: .get).responseArray { (response:DataResponse<[DribbbleShot]>) in
            if let shots = response.result.value {
                completion(true,shots,shots.isEmpty)
            } else {
                completion(false,[],true)
            }
        }
    }
}

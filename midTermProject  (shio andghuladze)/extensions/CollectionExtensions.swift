//
//  CollectionExtensions.swift
//  midTermProject  (shio andghuladze)
//
//  Created by shio andghuladze on 30.07.22.
//

import Foundation
import Firebase

extension Array where Element == User{
    
    func getChatTitle()-> String{
        var title = ""
        forEach{user in
            if UserDefaults.standard.user?.UUID != user.UUID{
                title += user.name + ", "
            }
        }
        let index = title.lastIndex(of: ",")!
        return String(title[..<index])
    }
    
    
    func generateChatId()-> String{
        return map{ $0.UUID }.sorted().joined(separator: "")
    }
    
}

extension NSEnumerator {
    
    func convertToObjectArray<T: Decodable>(type: T.Type)-> [T]{
        return compactMap{ snapshot in
            return (snapshot as? DataSnapshot)?.toObject(type: type)
        }
    }
    
}

extension NSDictionary{
    
    func convertToJsonString()-> String{
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        }catch _ {
            return ""
        }
    }
    
}

extension DataSnapshot{
    
    func toObject<T: Decodable>(type: T.Type)-> T?{
        if let dict = self.value as? NSDictionary{
            do {
                return try JSONDecoder().decode(type, from: dict.convertToJsonString().data(using: .utf8)!)
            }catch _ {
                print("invalid data. \(dict)")
            }
        }
        return nil
    }
    
}


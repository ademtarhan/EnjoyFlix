//
//  Data+.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 21.07.2023.
//

import Foundation


extension Data {
    private var prettyJSON: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted, .withoutEscapingSlashes]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
    
    func printData(){
        print(prettyJSON ?? "no data")
    }
    
}

//
//  Date+Extensions.swift
//  SpacePod15
//
//  Created by Mattia Fochesato on 22/11/21.
//

import Foundation

extension Date {
    
    //Print date to a human readable string
    func prettyPrint() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM YYYY"
        return dateFormatter.string(from: self)
    }
    
}

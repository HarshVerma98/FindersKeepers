//
//  StringExtension.swift
//  FindersKeepers
//
//  Created by Harsh Verma on 11/05/23.
//

import Foundation
extension String {
    var formatter: String {
        self.replacingOccurrences(of: " ", with: "")
        .replacingOccurrences(of: "+", with: "")
        .replacingOccurrences(of: "-", with: "")
        .replacingOccurrences(of: "(", with: "")
        .replacingOccurrences(of: ")", with: "")
        
    }
}

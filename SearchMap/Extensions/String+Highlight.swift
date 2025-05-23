//
//  String+Highlight.swift
//  SearchMap
//
//  Created by Hậu Nguyễn on 23/5/25.
//
import SwiftUI

extension String {
    func highlighted(with keyword: String) -> AttributedString {
        var attributed = AttributedString(self)
        
        let lowerSelf = self.lowercased()
        let lowerKeyword = keyword.lowercased()

        if let range = lowerSelf.range(of: lowerKeyword) {
            let nsRange = NSRange(range, in: self)
            
            if let swiftRange = Range(nsRange, in: attributed) {
                attributed[swiftRange].foregroundColor = .black
                attributed[swiftRange].font = .headline.bold()
            }
        }

        return attributed
    }
}


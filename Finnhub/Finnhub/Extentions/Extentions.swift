//
//  Extentions.swift
//  Finnhub
//
//  Created by Priyanka on 25/01/23.
//

import Foundation

extension Array {
    public mutating func appendIfUnique<T: Hashable>(_ newElement: Element, check property: ((Element) -> (T))) {
        
        for element in self {
            if property(element) == property(newElement) { return }
        }
        
        append(newElement)
    }
}

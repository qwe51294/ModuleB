//
//  Array+Copy.swift
//  ETicket
//
//  Created by chunjian wang on 2020/3/20.
//  Copyright © 2020 chunjian wang. All rights reserved.
//

import UIKit

public extension Array where Element: Equatable {
    
    subscript (safe index: Int) -> Element? {
        return (0..<count).contains(index) ? self[index] : nil
    }
    
    mutating func removeObject(_ object: Element) {
        if let index = self.firstIndex(of: object) {
            self.remove(at: index)
        }
    }
    
    mutating func removeObjectsInArray(_ array: [Element]) {
        for object in array {
            self.removeObject(object)
        }
    }
}

extension Array where Element:NSCopying{
    ///返回元素支持拷贝数组的深拷贝
    public var copy:[Element]{
        return self.map {$0.copy(with: nil) as! Element}
    }
}

extension Array {    
    func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
         var result = [Element]()
         for value in self {
             let key = filter(value)
             if !result.map({filter($0)}).contains(key) {
                 result.append(value)
             }
         }
         return result
     }
    
    /// 数组 最大 最小
    /// - Parameter array: 查询数组
    func findMaxMin<T:Comparable>(_ array:[T]) ->(min: T,max:T)? {
        guard var min = array.first else { return nil }
        var max = min
        let start = array.count % 2 // 如果个数为单数，则从index = 1开始遍历
        for i in stride(from: start, to: array.count, by: 2) {
            let pair = (array[i],array[i+1])
            
            if(pair.0 > pair.1){
                if pair.0 > max {
                    max = pair.0
                }
                
                if pair.1 < min {
                    min = pair.1
                }
                
            } else {
                if pair.1 > max {
                    max = pair.1
                }
                
                if pair.0 < min {
                    min = pair.0
                }
            }
        }
        return (min, max)
    }


}


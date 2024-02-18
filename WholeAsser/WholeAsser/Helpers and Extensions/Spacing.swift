//
//  Spacing.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/12/24.
//

import Foundation

struct Spacing {
    /// 4
    static let x1: CGFloat = 4
    
    /// 8
    static let x2: CGFloat = 8
    
    /// 12
    static let x3: CGFloat = 12
    
    /// 16
    static let x4: CGFloat = 16
    
    /// 20
    static let x5: CGFloat = 20
    
    /// 24
    static let x6: CGFloat = 24
    
    /// 28
    static let x7: CGFloat = 28
    
    /// 32
    static let x8: CGFloat = 32
    
    /// 36
    static let x9: CGFloat = 36
    
    /// 40
    static let x10: CGFloat = 40
    
    /// x multiplied by 4
    static func custom(x: Int) -> CGFloat {
        return CGFloat(x * 4)
    }
}

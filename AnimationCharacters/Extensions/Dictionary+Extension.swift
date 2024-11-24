//
//  Dictionary+Extension.swift
//  AnimationCharacters
//
//  Created by Mohamed Sadek on 24/11/2024.
//

import Foundation

extension Dictionary {
  static func + (firstValue: Dictionary, secondValue: Dictionary?) -> Dictionary {
    if secondValue == nil {
      return firstValue
    } else {
      var dic = firstValue
      secondValue!.forEach { dic[$0] = $1 }
      return dic
    }
  }
}

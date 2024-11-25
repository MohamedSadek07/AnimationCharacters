//
//  FilterStatuses.swift
//  AnimationCharacters
//
//  Created by Mohamed Sadek on 25/11/2024.
//

import Foundation

enum FilterStatuses: Int {
    case alive = 0
    case dead = 1
    case unknown = 2

    func returnString() -> String {
        switch self {
        case .alive:
            return "alive"
        case .dead:
            return "dead"
        case .unknown:
            return "unknown"
        }
    }
}

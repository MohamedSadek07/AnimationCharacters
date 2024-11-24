//
//  Bindable.swift
//  AnimationCharacters
//
//  Created by Mohamed Sadek on 24/11/2024.
//

import Foundation

class Bindable<T> {
    typealias Listener = ((T) -> Void)
    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ v: T) {
        self.value = v
    }

    func bind(_ listener: Listener?) {
        self.listener = listener
    }

    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}


internal final class Observer<Variable> {
    typealias Listener = (Variable?)->()
    private var listener: Listener?
    internal var value: Variable? {
        didSet {
            if value != nil {
                DispatchQueue.global(qos: .userInitiated)
                    .async { [weak self] in
                        self?.listener?(self?.value)
                    }
            }
        }
    }

    internal func bind(_ listener: Listener?) -> Void {
        DispatchQueue.global(qos: .userInitiated)
            .async { [weak self] in
                self?.listener = listener
                if self?.value != nil {
                    listener?(self?.value)
                }
            }
    }
}

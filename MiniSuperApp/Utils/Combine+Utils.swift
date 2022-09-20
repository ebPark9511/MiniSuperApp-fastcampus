//
//  Combine+Utils.swift
//  MiniSuperApp
//
//  Created by 박은비 on 2022/09/19.
//

import Combine
import CombineExt
import Foundation

public class ReadOnlyCurrentValuePublisher<Element>: Publisher {
    
    public typealias Output = Element
    public typealias Failure = Never
    
    public var value: Element {
        currentValueRelay.value
    }
    
    fileprivate let currentValueRelay: CurrentValueRelay<Output>
    
    fileprivate init(_ initalValue: Element) {
        currentValueRelay = CurrentValueRelay(initalValue)
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Element == S.Input {
        currentValueRelay.receive(subscriber: subscriber)
    }
}

public final class CurrentValuePublisher<Element>: ReadOnlyCurrentValuePublisher<Element> {
    
    public typealias Output = Element
    public typealias Failure = Never
    
    public override init(_ initalValue: Element) {
        super.init(initalValue)
    }
    
    public func send(_ value: Element) {
        currentValueRelay.accept(value)
    }
    
}

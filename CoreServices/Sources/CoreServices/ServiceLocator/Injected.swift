//
//  Injected.swift
//  
//
//  Created by Роман on 27.03.2023.
//

import Foundation

@propertyWrapper
public struct Injected<Service> {
    private var service: Service?
    
    public init() {}
    
    public var wrappedValue: Service? {
        mutating get {
            if service == nil {
                service = ServiceLocator.shared.getService()
            }
            return service
        }
    }
    
    public var projectedValue: Injected<Service> {
        mutating set {
            self = newValue
        }
        get {
            return self
        }
    }
}

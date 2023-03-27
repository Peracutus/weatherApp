//
//  ServiceLocator.swift
//  
//
//  Created by Роман on 27.03.2023.
//

import Foundation

protocol ServiceLocating {
    func getService<T>() -> T?
}

public final class ServiceLocator: ServiceLocating {
    public static let shared = ServiceLocator()
    
    private lazy var services: [String: Any] = [:]
    
    private func typeName(some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))'"
    }
    
   public func addService<T>(service: T) {
        let key = typeName(some: T.self)
        services[key] = service
    }
    
   public func getService<T>() -> T? {
        let key = typeName(some: T.self)
        return services[key] as? T
    }
}

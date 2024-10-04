//
//  DependencyContainer.swift
//  Search
//
//  Created by Paulo Correa on 04/10/2024.
//

import Foundation

public final actor DependencyContainer {
    private static var factories: [String: () -> Any] = [:]
    private static var cache: [String: Any] = [:]
}

extension DependencyContainer {
    public static func register<Service>(type: Service.Type, _ factory: @autoclosure @escaping () -> Service) {
        factories[String(describing: type.self)] = factory
    }
    
    public static func resolve<Service>(_ type: Service.Type) -> Service {
        let serviceName = String(describing: type.self)
        
        if let service = cache[serviceName] as? Service {
            return service
        } else {
            let service = factories[serviceName]?() as? Service
            
            guard let service = service else {
                fatalError("No service of type \(serviceName) registered!")
            }

            cache[serviceName] = service

            return service
        }
    }
}

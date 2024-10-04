//
//  Injected.swift
//  DependencyContainer
//
//  Created by Paulo Correa on 04/10/2024.
//

@propertyWrapper
public struct Injected<Service> {
    private var service: Service

    public init() {
        self.service = DependencyContainer.resolve(Service.self)
    }

    public var wrappedValue: Service {
        get { self.service }
        mutating set { service = newValue }
    }
}

//
//  Store.swift
//  RecipePuppy
//
//  Created by wearemobilefirst on 06/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation

protocol StoreListener: class {
    func didUpdateStore()
}

class ListenerWrapper {
    
    weak var listener: StoreListener?

    init(listener: StoreListener) {
        self.listener = listener
    }
    
}

protocol Store: AnyObject {
    associatedtype Model: Codable, Equatable

    var key: String { get }
    var defaults: UserDefaults { get }

    var encoder: JSONEncoder { get }
    var decoder: JSONDecoder { get }

    var values: [Model] { get set }
    var listeners: [ListenerWrapper] { get set }

    func add(_ value: Model)
    func add(listener: StoreListener)
    func remove(_ value: Model)
    func clear()

    func save()
    func contains(_ value: Model) -> Bool
}

extension Store {
    
    func add(_ value: Model) {
        guard !values.contains(value) else { return }
        values.insert(value, at: 0)
        save()
    }

    
    func add(listener: StoreListener) {
        let wrapper = ListenerWrapper(listener: listener)
        listeners.append(wrapper)
    }

    
    func remove(_ value: Model) {
        guard let offset = values.firstIndex(of: value) else { return }
        let index = values.startIndex.distance(to: offset)
        values.remove(at: index)
        save()
    }
    

    func clear() {
        values.removeAll()
        save()
    }

    
    func save() {
        guard let data = try? encoder.encode(values) else { return }
        defaults.set(data, forKey: key)
        listeners.forEach { $0.listener?.didUpdateStore() }
    }

    
    func contains(_ value: Model) -> Bool {
        return values.contains(value)
    }
    
}


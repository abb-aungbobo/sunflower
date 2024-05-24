//
//  PersistenceControllerImpl.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 05/03/2024.
//

import RealmSwift

final class PersistenceControllerImpl: PersistenceController {
    static let shared = PersistenceControllerImpl()
    
    private init() {}
    
    func add<Element: Object>(entity: Element) throws {
        let realm = try Realm()
        try realm.write {
            realm.add(entity, update: .modified)
        }
    }
    
    func add<Element: Object>(entities: [Element]) throws {
        let realm = try Realm()
        realm.beginWrite()
        realm.add(entities, update: .modified)
        try realm.commitWrite()
    }
    
    func get<Element: Object, Key>(ofType type: Element.Type, forPrimaryKey key: Key) throws -> Element?  {
        let realm = try Realm()
        let object = realm.object(ofType: type, forPrimaryKey: key)
        return object
    }
    
    func get<Element: Object>() throws -> [Element] {
        let realm = try Realm()
        let results = realm.objects(Element.self)
        return Array(results)
    }
    
    func update<Result>(_ block: (() throws -> Result)) throws {
        let realm = try Realm()
        try realm.write(block)
    }
    
    func delete<Element: Object>(entity: Element) throws {
        let realm = try Realm()
        try realm.write {
            realm.delete(entity)
        }
    }
}

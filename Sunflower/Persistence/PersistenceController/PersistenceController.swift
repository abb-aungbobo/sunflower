//
//  PersistenceController.swift
//  Sunflower
//
//  Created by Aung Bo Bo on 05/03/2024.
//

import RealmSwift

protocol PersistenceController {
    func add<Element: Object>(entity: Element) throws
    func add<Element: Object>(entities: [Element]) throws
    func get<Element: Object, Key>(ofType type: Element.Type, forPrimaryKey key: Key) throws -> Element?
    func get<Element: Object>() throws -> [Element]
    func update<Result>(_ block: (() throws -> Result)) throws
    func delete<Element: Object>(entity: Element) throws
}

//
//  CoreDataContext.swift
//  todoTests
//
//  Created by DE4ME on 12.03.2026.
//

import CoreData;


func memoryPersistentContainer() -> NSPersistentCloudKitContainer {
    // Swift is smart enough to execute this only once
    let container = NSPersistentCloudKitContainer(name: "todo");
    let description = NSPersistentStoreDescription();
    description.type = NSInMemoryStoreType;
    container.persistentStoreDescriptions = [description];
    container.loadPersistentStores(completionHandler: { (description, error) in
        if let error = error {
            fatalError("Failed to load store for Tests: \(error)");
        }
    })
    return container;
}


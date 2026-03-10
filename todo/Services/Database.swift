//
//  Database.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import CoreData;


protocol DatabaseObjectID {
    func objectId() -> NSManagedObjectID?;
}


protocol DatabaseProtocol {
    var mainContext: NSManagedObjectContext { get }
    var privateContext: NSManagedObjectContext { get }
    func save(todos: [Todo], completionHandler: @escaping (Error?) -> Void);
    func delete(objects: [any DatabaseObjectID], completionHandler: @escaping (Error?) -> Void);
}


final class Database: DatabaseProtocol {
    
    static let shared: DatabaseProtocol = Database();
    
    //MARK: CONST
    
    private let workQueue = DispatchQueue(label: "com.de4me.todo.database", qos: .userInitiated);
    
    //MARK: GET
    
    var mainContext: NSManagedObjectContext {
        self.persistentContainer.viewContext;
    }
    
    //MARK: VAR
    
    
    lazy var privateContext: NSManagedObjectContext = {
        self.persistentContainer.newBackgroundContext();
    }();
    
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentCloudKitContainer(name: "todo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext() throws {
        let context = self.mainContext;
        guard context.hasChanges else{
            return;
        }
        try context.save();
    }
    
    //MARK: OVERRIDE
    
    init() {
        let nc = NotificationCenter.default;
        nc.addObserver(self, selector: #selector(self.privateContextDidSaveNotify(_:)), name: Notification.Name.NSManagedObjectContextDidSave, object: self.privateContext);
        nc.addObserver(self, selector: #selector(self.mainContextDidSaveNotify(_:)), name: Notification.Name.NSManagedObjectContextDidSave, object: self.mainContext);
    }
    
    //MARK: NOTIFY
    
    @objc func privateContextDidSaveNotify(_ notify: Notification) {
        let context = self.mainContext;
        context.perform {
            context.mergeChanges(fromContextDidSave: notify);
        }
    }
    
    @objc func mainContextDidSaveNotify(_ notify: Notification) {
        let context = self.privateContext;
        context.perform {
            context.mergeChanges(fromContextDidSave: notify);
        }
    }
    
    //MARK: FUNC
    
#if DEBUG
    func debug(){
        do{
            let fetch1:NSFetchRequest<DBTodo> = DBTodo.fetchRequest();
            let array1 = try self.privateContext.fetch(fetch1);
            print("***");
            array1.forEach{ print($0.objectID, $0.title ?? "?", $0.subtitle ?? "?") }
        }
        catch{
            print(error);
        }
    }
#endif
    
    func save(todos: [Todo], completionHandler: @escaping (Error?) -> Void) {
        self.workQueue.async {
            do {
                try todos.forEach { todo in
                    let object: DBTodo = todo.id != nil ? try self.privateContext.existingObject(with: todo.id!) as! DBTodo : DBTodo(entity: DBTodo.entity(), insertInto: self.privateContext);
                    object.assign(todo: todo);
                }
                guard self.privateContext.hasChanges else {
                    return;
                }
                try self.privateContext.save();
                completionHandler(nil);
            }
            catch {
                self.privateContext.rollback();
                completionHandler(error);
            }
        }
    }
    
    func delete(objects: [any DatabaseObjectID], completionHandler: @escaping (Error?) -> Void) {
        self.workQueue.async {
            do {
                objects.forEach { object in
                    guard let objectid = object.objectId() else {
                        return;
                    }
                    let session = self.privateContext.object(with: objectid);
                    self.privateContext.delete(session);
                }
                guard self.privateContext.hasChanges else {
                    return;
                }
                try self.privateContext.save();
                completionHandler(nil);
            }
            catch {
                self.privateContext.rollback();
                completionHandler(error);
            }
        }
    }
    
}

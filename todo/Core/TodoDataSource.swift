//
//  TodoDataSource.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import CoreData;


protocol TodoDataSourceInput: AnyObject {
    var output: TodoDataSourceOutput? { get set }
    func fetch() throws;
    func dataSource(numberOfRowsInSection section: Int) -> Int;
    func dataSource(objectAt index: Int) -> Todo?;
    func search(text: String?) throws;
}


protocol TodoDataSourceOutput: AnyObject {
    func didChangeContent();
}


class TodoDataSource: NSObject, TodoDataSourceInput {
    
    private var fetchedResultsController: NSFetchedResultsController<DBTodo>!;
    weak var output: TodoDataSourceOutput?;
    private var currentSearchText: String?;
    
    init(output: TodoDataSourceOutput) {
        let request = DBTodo.fetchRequest();
        let sort = NSSortDescriptor(key: #keyPath(DBTodo.createdDate), ascending: false);
        request.sortDescriptors = [sort];
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Database.shared.mainContext, sectionNameKeyPath: nil, cacheName: nil);
        self.output = output;
        super.init();
        self.fetchedResultsController.delegate = self;
    }
    
    func fetch() throws {
        try self.fetchedResultsController.performFetch();
        self.output?.didChangeContent();
    }
    
    func dataSource(numberOfRowsInSection section: Int) -> Int {
        self.fetchedResultsController.fetchedObjects?.count ?? 0;
    }
    
    func dataSource(objectAt index: Int) -> Todo? {
        guard let object = self.fetchedResultsController.fetchedObjects?[index] else {
            return nil;
        }
        return Todo(db: object);
    }
    
    func search(text: String?) throws {
        guard text != self.currentSearchText else {
            return;
        }
        if let text, !text.isEmpty {
            self.currentSearchText = text;
            let predicate = NSPredicate(format: "%K contains[c] %@ || %K contains[c] %@", #keyPath(DBTodo.title), text, #keyPath(DBTodo.subtitle), text);
            self.fetchedResultsController.fetchRequest.predicate = predicate;
        } else {
            self.currentSearchText = nil;
            self.fetchedResultsController.fetchRequest.predicate = nil;
        }
        try self.fetch();
    }
    
}


extension TodoDataSource: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        self.output?.didChangeContent();
    }
    
}

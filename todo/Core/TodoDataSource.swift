//
//  TodoDataSource.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import CoreData;


protocol TodoDataSourceInput: AnyObject {
    var output: TodoDataSourceOutput? { get set }
    var isFetched: Bool { get }
    func fetch() throws;
    func dataSource(numberOfRowsInSection section: Int) -> Int;
    func dataSource(objectAt index: Int) -> Todo?;
    func search(text: String?) throws;
}


protocol TodoDataSourceOutput: AnyObject {
    func didChangeContent(updates: DataSourceUpdates?);
}


class TodoDataSource: NSObject, TodoDataSourceInput {
    
    private var fetchedResultsController: NSFetchedResultsController<DBTodo>!;
    weak var output: TodoDataSourceOutput?;
    private var currentSearchText: String?;
    private var insertedIndexPaths: [IndexPath];
    private var deletedIndexPaths: [IndexPath];
    private var updatedIndexPaths: [IndexPath];
    private var movedIndexPaths: [(from: IndexPath, to: IndexPath)];
    private(set) var isFetched: Bool;
    
    init(output: TodoDataSourceOutput) {
        self.isFetched = false;
        self.insertedIndexPaths = [];
        self.deletedIndexPaths = [];
        self.updatedIndexPaths = [];
        self.movedIndexPaths = [];
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
        self.isFetched = true;
        self.output?.didChangeContent(updates: nil);
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
    
    private func cleanIndexes() {
        self.insertedIndexPaths = [];
        self.deletedIndexPaths = [];
        self.updatedIndexPaths = [];
        self.movedIndexPaths = [];
    }
    
}


extension TodoDataSource: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        self.cleanIndexes();
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        let updates = DataSourceUpdates(inserted: self.insertedIndexPaths, deleted: self.deletedIndexPaths, updated: self.updatedIndexPaths, moved: self.movedIndexPaths);
        self.output?.didChangeContent(updates: updates);
        self.cleanIndexes();
    }
    
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath else {
                return;
            }
            self.insertedIndexPaths.append(newIndexPath);
        case .delete:
            guard let indexPath else {
                return;
            }
            self.deletedIndexPaths.append(indexPath);
        case .update:
            guard let indexPath else {
                return;
            }
            self.updatedIndexPaths.append(indexPath);
        case .move:
            guard let indexPath,
                  let newIndexPath
            else {
                return;
            }
            self.movedIndexPaths.append((from: indexPath, to: newIndexPath));
        default:
            return;
        }
    }
    
}

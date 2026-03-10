//
//  Todo.swift
//  todo
//
//  Created by DE4ME on 08.03.2026.
//

import Foundation;
import CoreData;


struct Todo {
    
    let id: NSManagedObjectID?;
    var title: String;
    var subtitle: String;
    let createdDate: Date;
    var completedDate: Date?;
    
    var isCompleted: Bool {
        self.completedDate != nil;
    }
    
    var localizedCreatedDate: String {
        DateFormatter.localizedString(from: self.createdDate, dateStyle: .short, timeStyle: .none);
    }
    
    var localizedCompletedDate: String? {
        self.completedDate != nil ? DateFormatter.localizedString(from: self.completedDate!, dateStyle: .short, timeStyle: .none) : nil;
    }
    
    init(id: NSManagedObjectID? = nil, title: String? = nil, subtitle: String? = nil, createdDate: Date? = nil, completedDate: Date? = nil) {
        self.id = id;
        self.title = title ?? "";
        self.subtitle = subtitle ?? "";
        self.createdDate = createdDate ?? Date();
        self.completedDate = completedDate;
    }
    
}


extension Todo: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id;
        case title;
        case subtitle = "todo";
        case createdDate;
        case completedDate;
        case completed;
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = nil;
        let id = try container.decode(Int.self, forKey: .id);
        self.title = "#\(id)";
        self.subtitle = try container.decode(String.self, forKey: .subtitle);
        self.createdDate = Date();
        let completed = try container.decode(Bool.self, forKey: .completed);
        self.completedDate = completed ? Date() : nil;
    }
    
}


extension Todo: DatabaseObjectID {
    
    func objectId() -> NSManagedObjectID? {
        self.id;
    }
    
}

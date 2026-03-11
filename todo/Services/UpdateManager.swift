//
//  UpdateManager.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//

import Foundation;
import Network;


protocol UpdateManagerProtocol: AnyObject {
    func start();
    func stop();
}


final class UpdateManager: UpdateManagerProtocol {
    
    static let shared: UpdateManagerProtocol = UpdateManager();
    
    private var monitor: NetworkMonitorInput!;
    private var preferences: PreferencesProtocol!;
    
    init() {
        self.preferences = Preferences();
        self.monitor = NetworkMonitor(output: self);
    }
    
    func start() {
        self.monitor.start();
    }
    
    func stop() {
        self.monitor.stop();
    }
    
}


extension UpdateManager: NetworkMonitorOutput {
    
    private func databaseHandler(_ error: Error?) {
        guard error == nil else {
            return;
        }
        self.preferences.updated = true;
    }
    
    private func updateHandler(_ result: Result<TodoResponce, Error>) {
        switch result {
        case .success(let responce):
            Database.shared.save(todos: responce.todos, completionHandler: self.databaseHandler);
        case .failure(let error):
            print(error);
            break;
        }
    }
    
    func networkMonitor(connected: Bool, interface: NWInterface.InterfaceType?) {
        guard connected else {
            return;
        }
        if !self.preferences.updated {
            Server.shared.get(path: Server.Path.todos, type: TodoResponce.self, completionHandler: self.updateHandler);
        }
    }
    
}


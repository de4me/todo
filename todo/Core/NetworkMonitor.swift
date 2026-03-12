//
//  NetworkMonitor.swift
//  todo
//
//  Created by DE4ME on 09.03.2026.
//


import Foundation;
import Network;


protocol NetworkMonitorInput: AnyObject {
    var output: NetworkMonitorOutput? { get set }
    var isConnected: Bool { get }
    var interface: NWInterface.InterfaceType? { get }
    func start();
    func stop();
}


protocol NetworkMonitorOutput: AnyObject {
    func networkMonitor(connected: Bool, interface: NWInterface.InterfaceType?);
}


class NetworkMonitor: NSObject, NetworkMonitorInput {
    
    //MARK: VAR
    
    private let monitor: NWPathMonitor;
    private(set) var isConnected: Bool;
    private(set) var interface: NWInterface.InterfaceType?;
    private let workQueue: DispatchQueue;
    weak var output: NetworkMonitorOutput?;
    
    init(output: NetworkMonitorOutput?) {
        self.monitor = NWPathMonitor();
        self.isConnected = false;
        self.workQueue = DispatchQueue(label: "com.de4me.todo.reachability");
        self.output = output;
    }
    
    @objc private func notify() {
        self.output?.networkMonitor(connected: self.isConnected, interface: self.interface);
    }
    
    private func monitorHandler(_ path: NWPath) {
        self.isConnected = path.status == .satisfied;
        self.interface = path.availableInterfaces.first?.type;
        self.performSelector(onMainThread: #selector(self.notify), with: nil, waitUntilDone: false);
    }
    
    func start() {
        self.monitor.pathUpdateHandler = self.monitorHandler;
        self.monitor.start(queue: self.workQueue);
    }
    
    func stop() {
        self.monitor.pathUpdateHandler = nil;
        self.monitor.cancel();
    }
    
}

//
//  DataSourceUpdates.swift
//  todo
//
//  Created by DE4ME on 13.03.2026.
//

import Foundation;


struct DataSourceUpdates {
    let inserted: [IndexPath];
    let deleted: [IndexPath];
    let updated: [IndexPath];
    let moved: [(from: IndexPath, to: IndexPath)];
}

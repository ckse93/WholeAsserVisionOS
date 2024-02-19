//
//  SchemaV1_0_0.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/14/24.
//

import CloudKit
import Foundation
import SwiftData

enum SchemaV1_0_0: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)
    static var models: [any PersistentModel.Type] {
        [TaskData.self]
    }
}

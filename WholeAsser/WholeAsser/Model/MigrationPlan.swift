//
//  MigrationPlan.swift
//  WholeAsser
//
//  Created by Chan Jung on 2/14/24.
//

import Foundation
import SwiftData

enum DataMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [
            SchemaV1_0_0.self,
//            SchemaV2_0_0.self,
        ]
    }
    
//    static let migrateV1toV2 = MigrationStage.custom(
//        fromVersion: SchemaV1_0_0.self,
//        toVersion: SchemaV2_0_0.self,
//        willMigrate: nil,
//        didMigrate: nil)
    
    static var stages: [MigrationStage] {
        [/*migrateV1toV2*/]
    }
}

//
//  Solve+CoreDataProperties.swift
//  Tap Timer
//
//  Created by Bryan Smith on 8/26/20.
//
//

import Foundation
import CoreData


extension Solve {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Solve> {
        return NSFetchRequest<Solve>(entityName: "Solve")
    }

    @NSManaged public var solveTime: Double
    @NSManaged public var solveDate: Date?

}

extension Solve : Identifiable {

}

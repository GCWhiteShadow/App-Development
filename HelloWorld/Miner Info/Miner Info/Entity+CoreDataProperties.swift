//
//  Entity+CoreDataProperties.swift
//  Miner Info
//
//  Created by GCWhiteShadow on 2017/7/5.
//  Copyright © 2017年 GCWhiteShadow. All rights reserved.
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var addr: String?

}

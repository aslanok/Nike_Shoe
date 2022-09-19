//
//  Entity.swift
//  NikeApp
//
//  Created by MacBook on 16.09.2022.
//

import Foundation
import CoreData

@objc(Entity)

public class Entity: NSManagedObject{
    
}

extension Entity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }
    
    @NSManaged public var brandtext : String?
    @NSManaged public var descriptiontext : String?
    @NSManaged public var price : NSNumber?
    @NSManaged public var image : NSData?
    
}


//
//  Tag+CoreDataProperties.swift
//  
//
//  Created by JongHo Park on 2022/03/15.
//
//

import Foundation
import CoreData

extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var category: String?
    @NSManaged public var colorHex: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var tagDescription: String?

}

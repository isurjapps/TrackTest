//
//  UserCredentials+CoreDataProperties.swift
//  CarTrack
//
//  Created by Prashant Singh on 13/5/21.
//
//

import Foundation
import CoreData


extension UserCredentials {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCredentials> {
        return NSFetchRequest<UserCredentials>(entityName: "UserCredentials")
    }

    @NSManaged public var userName: String?
    @NSManaged public var password: String?

}

extension UserCredentials : Identifiable {

}

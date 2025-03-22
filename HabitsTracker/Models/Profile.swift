//
//  Profile.swift
//  HabitsTracker
//
//  Created by KsArT on 22.03.2025.
//

import Foundation

enum Profile {
    private(set) static var user: User?
    
    static func login(_ user : User) {
        self.user = user
    }
    
    static func logout() {
        self.user = nil
    }
}

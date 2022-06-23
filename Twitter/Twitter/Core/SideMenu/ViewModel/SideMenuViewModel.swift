//
//  SideMenuViewModel.swift
//  Twitter
//
//  Created by Andrei Mareși on 16.06.2022.
//

import Foundation
import SwiftUI

enum SideMenuViewModel: Int, CaseIterable {
    case profile
    case liste
    case bookmarks
    case topics
    case moments
    case purchases
    case monetisation
    case logout
    
    var description: String {
        switch self {
        case .profile: return "Profile"
        case .liste: return "Update information"
        case .bookmarks: return "Bookmarks"
        case .topics: return "Topics"
        case .moments: return "Moments"
        case .purchases: return "Purchases"
        case .monetisation: return "Monetisation"
        case .logout: return "Logout"
        }
    }
    
    var imageName: String {
        switch self {
        case .profile: return "person"
        case .liste: return "list.bullet"
        case .bookmarks: return "bookmark"
        case .topics: return "message.fill"
        case .moments: return "bolt"
        case .purchases: return "cart"
        case .monetisation: return "banknote"
        case .logout: return "arrow.left.square"
        }
    }
    
}

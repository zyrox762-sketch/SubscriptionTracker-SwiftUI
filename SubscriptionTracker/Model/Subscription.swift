//
//  Subscription.swift
//  SubscriptionTracker
//
//  Created by !---------? on 25/09/2026.
//

import Foundation

struct Subscription:Identifiable{
    var id = UUID()
    var name:String
    var price:Double
    var formattedPrice: String {
        return String(format: "$%.2f", price)
    }
    var date:Date
    var formattedDate: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: date)
    }
    var billingCycle:BillingCycle
    var category:String
}
enum BillingCycle{
    case monthly
    case yearly
    var displayName:String{
        switch self{
        case .monthly:
            return "Monthly"
        case .yearly:
            return "Yearly"
        }
    }
}


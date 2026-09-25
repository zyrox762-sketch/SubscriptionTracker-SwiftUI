//
//  SubscriptionViewModel.swift
//  SubscriptionTracker
//
//  Created by !---------? on 25/09/2026.
//

import Foundation

@MainActor
class SubscriptionViewModel:ObservableObject{
    @Published var subscriptions:[Subscription] = [
        Subscription(name: "Gamers", price: 99.9, date: Date.now, billingCycle: BillingCycle.monthly, category: "Play"),
        Subscription(name: "Cards", price: 19.9, date: Date.now, billingCycle: BillingCycle.yearly, category: "Gift Cards"),
        Subscription(name: "T-Shirt", price: 50, date: Date.now, billingCycle: .yearly, category: "Clothes")
    ]
    @Published var selectedBillingCycle:BillingCycle?
    @Published var searchText:String = ""
    @Published var isAscending:Bool = true
    
    func addSubscription(subscription:Subscription) {
        subscriptions.append(subscription)
    }
    func deleteSubscription(subscription:Subscription){
        subscriptions = subscriptions.filter({ item in
            subscription.id != item.id
        })
        
    }
    
    var monthlyTotal:Double{
        let monthlyPrices = subscriptions.map { subscription -> Double in
            switch subscription.billingCycle{
            case .monthly:
                return subscription.price
            case .yearly:
                return subscription.price / 12
            }
        }
       return monthlyPrices.reduce(0) {
            $0 + $1
        }
    }
    var yearlyTotal:Double{
        let yearlyPrices = subscriptions.map { subscription -> Double in
            switch subscription.billingCycle{
            case .monthly:
                return subscription.price * 12
            case .yearly:
                return subscription.price
            }
        }
        return yearlyPrices.reduce(0) {
            $0 + $1
        }
    }
    var monthlySubscriptions:[Subscription]{
        subscriptions.filter { subscription in
            return subscription.billingCycle == .monthly
        }
    }
    var yearlySubscriptions:[Subscription]{
        subscriptions.filter { subscription in
            return subscription.billingCycle == .yearly
        }
    }
   
    var filteredSubscriptions:[Subscription]{
        switch selectedBillingCycle{
        case .monthly:
            return monthlySubscriptions
        case .yearly:
            return yearlySubscriptions
        case nil:
            return subscriptions
        }
    }
    var searchedSubscriptions: [Subscription] {
        let subscriptions = filteredSubscriptions
        if searchText.isEmpty{
            return subscriptions
        }
        else{
            return subscriptions.filter { subscription in
                subscription.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    var sortedSubscriptions:[Subscription]{
        let subscriptions = searchedSubscriptions
        return subscriptions.sorted { first, second in
            if isAscending{
               return first.price < second.price
            }
            else{
               return first.price > second.price
            }
        }
    }
    var upcomingSubscriptions: [Subscription] {
        let subscriptions = searchedSubscriptions
        return subscriptions.sorted { first, second in
            first.date < second.date
        }
    }
    var nextSubscription: Subscription? {
        let subscriptions = upcomingSubscriptions
        return subscriptions.first
        
    }
    func updateSubscription(
        subscription: Subscription,
        name: String,
        price: Double,
        date: Date,
        billingCycle: BillingCycle,
        category: String
    ) {
        let index = subscriptions.firstIndex { item in
            subscription.id == item.id
        }

        guard let index = index else {
            return
        }
        subscriptions[index].name = name
        subscriptions[index].price = price
        subscriptions[index].date = date
        subscriptions[index].billingCycle = billingCycle
        subscriptions[index].category = category
    }
    
}

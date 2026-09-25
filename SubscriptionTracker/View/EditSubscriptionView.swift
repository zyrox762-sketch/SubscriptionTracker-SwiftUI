//
//  EditSubscriptionView.swift
//  SubscriptionTracker
//
//  Created by !---------? on 25/09/2026.
//

import SwiftUI

struct EditSubscriptionView: View {
    @ObservedObject var vm: SubscriptionViewModel
    @Environment(\.dismiss) var dismiss
    
    let subscription:Subscription
    @State private var name = ""
    @State private var price = ""
    @State private var billingCycle: BillingCycle = .monthly
    @State private var date = Date.now
    @State private var category = ""
    var body: some View {
        VStack{
            TextField("Subscription Name", text: $name)
                .font(.title2)
                .background(Color.secondary.opacity(0.12))
                .padding(.horizontal)
            TextField("Price", text: $price)
                .font(.title2)
                .background(Color.secondary.opacity(0.12))
                .padding(.horizontal)
            
            Picker("", selection: $billingCycle) {
                Text("Monthly")
                    .tag(BillingCycle.monthly)
                Text("Yearly")
                    .tag(BillingCycle.yearly)
            }
            DatePicker("Next Payment", selection: $date, displayedComponents: .date)
                .padding(.horizontal)
            
            TextField("Category", text: $category)
                .font(.title2)
                .background(Color.secondary.opacity(0.12))
                .padding(.horizontal)
            
            Button("Save") {
                guard !name.isEmpty, !category.isEmpty else {
                    return
                }

                guard let price = Double(price) else {
                    return
                }
                vm.updateSubscription(subscription: subscription, name: name, price: price, date: date, billingCycle: billingCycle, category: category)
                dismiss()
                
            }
            .buttonStyle(.borderedProminent)
        }
        .onAppear {
            name = subscription.name
            price = String(subscription.price)
            billingCycle = subscription.billingCycle
            date = subscription.date
            category = subscription.category
        }
    }
}

struct EditSubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        EditSubscriptionView(vm: SubscriptionViewModel(), subscription: Subscription(name: "", price: 0, date: Date.now, billingCycle: BillingCycle.yearly, category: ""))
    }
}

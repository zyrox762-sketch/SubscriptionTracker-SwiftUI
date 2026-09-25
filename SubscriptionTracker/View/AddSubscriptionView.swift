//
//  AddSubscriptionView.swift
//  SubscriptionTracker
//
//  Created by !---------? on 25/09/2026.
//

import SwiftUI

struct AddSubscriptionView: View {
    @ObservedObject var vm:SubscriptionViewModel
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var price = ""
    @State private var billingCycle: BillingCycle = .yearly
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
            
            Button("Add Subscription") {
                guard !name.isEmpty, !category.isEmpty else {
                    return
                }

                guard let price = Double(price) else {
                    return
                }
                let newSubscription = Subscription(
                    name: name,
                    price: price,
                    date: date,
                    billingCycle: billingCycle,
                    category: category
                )
                vm.addSubscription(subscription: newSubscription)
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        
        
    }
}

struct AddSubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        AddSubscriptionView(vm: SubscriptionViewModel())
    }
}

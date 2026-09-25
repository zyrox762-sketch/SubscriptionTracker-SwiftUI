//
//  SubscriptionRowView.swift
//  SubscriptionTracker
//
//  Created by !---------? on 25/09/2026.
//

import SwiftUI

struct SubscriptionRowView: View {
    let Row : Subscription
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 4){
                Text(Row.name)
                    .font(.title2)
                    .bold()
                Text(Row.category)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(Row.formattedDate)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(Row.billingCycle.displayName)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
                
            Spacer()
            Text(Row.formattedPrice)
                .font(.title3)
                .bold()
        }
    }
}

struct SubscriptionRowView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionRowView(Row: Subscription(name: "", price: 0, date: Date.now, billingCycle: BillingCycle.yearly, category: ""))
    }
}

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = SubscriptionViewModel()
    @State private var showingAddSubscription = false
    @State private var selectedSubscription: Subscription?

    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                
                Text("Monthly Spending")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text("$\(vm.monthlyTotal, specifier: "%0.2f")")
                    .font(.largeTitle)
                    .bold()

                Picker("", selection: $vm.selectedBillingCycle) {
                    Text("All")
                        .font(.headline)
                        .tag(nil as BillingCycle?)

                    Text("Monthly")
                        .font(.headline)
                        .tag(BillingCycle.monthly as BillingCycle?)

                    Text("Yearly")
                        .font(.headline)
                        .tag(BillingCycle.yearly as BillingCycle?)
                }
                .pickerStyle(.segmented)

                TextField("Search Subscriptions", text: $vm.searchText)
                    .padding()
                    .font(.title2)
                    .background(Color.secondary.opacity(0.12))
                    .cornerRadius(8)
                    .padding(.horizontal)

                if vm.upcomingSubscriptions.isEmpty {
                    Text("No subscriptions")
                } else {
                    List {
                        Section("Upcoming") {
                            ForEach(vm.upcomingSubscriptions) { subscription in
                                SubscriptionRowView(Row: subscription)
                                    .onTapGesture {
                                        selectedSubscription = subscription
                                    }
                            }
                            .onDelete { indexSet in
                                for index in indexSet {
                                    let subscription = vm.upcomingSubscriptions[index]
                                    vm.deleteSubscription(subscription: subscription)
                                }
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddSubscription.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(item: $selectedSubscription) { subscription in
                EditSubscriptionView(
                    vm: vm,
                    subscription: subscription
                )
            }
            .sheet(isPresented: $showingAddSubscription) {
                AddSubscriptionView(vm: vm)
            }
            .navigationTitle("Subscriptions")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

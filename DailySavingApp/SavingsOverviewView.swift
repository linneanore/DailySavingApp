import SwiftUI

struct SavingsOverviewView: View {
    @State private var savingsPlans: [SavingsPlan] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Your Savings Goals")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                List {
                    ForEach(savingsPlans) { plan in
                        NavigationLink(destination: SavingsPlanView(savingsGoal: plan.savingsGoal, totalDays: plan.totalDays)) {
                            VStack(alignment: .leading) {
                                Text("Goal: \(plan.savingsGoal) kr")
                                    .font(.headline)
                                Text("Days: \(plan.totalDays)")
                                    .font(.subheadline)
                            }
                        }
                    }
                    .onDelete(perform: deletePlan)
                }
                
                NavigationLink(destination: ContentView(addPlan: addSavingsPlan)) {
                    Text("Create New Savings Plan")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding()
            }
            .onAppear(perform: loadData)
        }
    }
    
    func addSavingsPlan(plan: SavingsPlan) {
        savingsPlans.append(plan)
        saveData()
    }
    
    func deletePlan(at offsets: IndexSet) {
        savingsPlans.remove(atOffsets: offsets)
    }
    
    func removeSavingsPlan(_ plan: SavingsPlan) {
        savingsPlans.removeAll { $0.id == plan.id }
    }
    
    func saveData() {
        if let encoded = try? JSONEncoder().encode(savingsPlans) {
            UserDefaults.standard.set(encoded, forKey: "savingsPlans")
        }
        
    }
    
    func loadData() {
        if let savedData = UserDefaults.standard.data(forKey: "savingsPlans"),
           let decoded = try? JSONDecoder().decode([SavingsPlan].self, from: savedData) {
            savingsPlans = decoded
        }
    }
}

struct SavingsPlan: Identifiable, Codable {
    var id = UUID()
    let savingsGoal: Int
    let totalDays: Int
    
    init(savingsGoal: Int, totalDays: Int) {
        self.savingsGoal = savingsGoal
        self.totalDays = totalDays
    }
}


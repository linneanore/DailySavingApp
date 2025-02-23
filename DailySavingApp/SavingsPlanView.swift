import SwiftUI

struct SavingsPlanView: View {
    let savingsGoal: Int
    let totalDays: Int
    
    @State private var remainingDays: Int
    @State private var savedAmounts: [Int] = [] {
        didSet {
            saveData()
        }
    }

    
    init(savingsGoal: Int, totalDays: Int) {
        self.savingsGoal = savingsGoal
        self.totalDays = totalDays
        _remainingDays = State(initialValue: totalDays)
        _savedAmounts = State(initialValue: UserDefaults.standard.array(forKey: "savedAmounts") as? [Int] ?? [])
    }

    
    var totalSaved: Int {
        savedAmounts.reduce(0, +)
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Total Saved: \(totalSaved) / \(savingsGoal) kr")
                .font(.headline)

            ProgressView(value: Double(totalSaved), total: Double(savingsGoal))
                .padding()

            Button(action: generateDailyAmount) {
                Text("Get today's saving amount")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            List(savedAmounts.indices, id: \.self) { index in
                Text("Day \(index + 1): Saved \(savedAmounts[index]) kr")
            }
        }
        .padding()
        .onAppear(perform: loadData)
    }

    
    func generateDailyAmount() {
        if remainingDays > 0 {
            let remainingAmount = savingsGoal - totalSaved
            let maxDailyLimit = min(750, remainingAmount - (remainingDays - 1))
            let dailyAmount = Int.random(in: 1...maxDailyLimit)
            
            savedAmounts.append(dailyAmount)
            remainingDays -= 1
            saveData()
            
        }
    }
    
    func saveData() {
        UserDefaults.standard.set(savedAmounts, forKey: "savedAmounts")
    }
    
    func loadData() {
        if let loadedData = UserDefaults.standard.array(forKey: "savedAmounts") as? [Int] {
            savedAmounts = loadedData
        }
    }
}

import SwiftUI

struct SavingsPlanView: View {
    let savingsGoal: Int
    let totalDays: Int
    
    @State private var remainingDays: Int
    @State private var savedAmounts: [Int] = []

    
    init(savingsGoal: Int, totalDays: Int) {
        self.savingsGoal = savingsGoal
        self.totalDays = totalDays
        _remainingDays = State(initialValue: totalDays)
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

            List(savedAmounts, id: \.self) { amount in
                Text("Saved: \(amount) kr")
            }
        }
        .padding()
    }

    
    func generateDailyAmount() {
        if remainingDays > 0 {
            let remainingAmount = savingsGoal - totalSaved
            let dailyAmount = max(1, remainingAmount / remainingDays) // Minsta belopp 1 kr
            savedAmounts.append(dailyAmount)
            remainingDays -= 1
        }
    }
}

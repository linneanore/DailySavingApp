import SwiftUI

struct ContentView: View {
    var addPlan: ((SavingsPlan) -> Void)?
    @State private var savingsGoal: String = ""
    @State private var selectedTimeframe: String = "Days"
    @State private var timeFrameValue: String = ""
    @State private var timeframes = ["Days", "Weeks", "Months"]
    @State private var navigateToSavingsPlan = false

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.8), Color.purple.opacity(0.4)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Text("Daily Savings")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(radius: 5)

                    TextField("Enter savings goal", text: $savingsGoal)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                        .keyboardType(.numberPad)
                        .padding(.horizontal, 40)

                    HStack {
                        TextField("Enter number", text: $timeFrameValue)
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(10)
                            .keyboardType(.numberPad)

                        Picker("Timeframe", selection: $selectedTimeframe) {
                            ForEach(timeframes, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    .padding(.horizontal, 40)

                    
                    Button(action: {
                        if let goal = Int(savingsGoal), let days = Int(timeFrameValue), goal > 0, days > 0 {
                            let newPlan = SavingsPlan(savingsGoal: goal, totalDays: calculateTotalDays())
                            addPlan?(newPlan)
                        }
                    }) {
                        Text("Start Savings Plan")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.9))
                            .foregroundColor(.purple)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal, 40)
                }
            }
            
            .navigationDestination(isPresented: $navigateToSavingsPlan) {
                SavingsPlanView(
                    savingsGoal: Int(savingsGoal) ?? 0,
                    totalDays: calculateTotalDays()
                )
            }
        }
    }

    func calculateTotalDays() -> Int {
        let value = Int(timeFrameValue) ?? 1
        switch selectedTimeframe {
        case "Weeks": return value * 7
        case "Months": return value * 30
        default: return value
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
    


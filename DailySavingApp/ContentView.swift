import SwiftUI

struct ContentView: View {
    @State private var savingsGoal: String = ""
    @State private var selectedTimeframe: String = "Days"
    @State private var timeframes = ["Days", "Weeks", "Months"]
    @State private var savingsPlanStarted = false
    
    var body: some View {
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
                
                Picker("Timeframe", selection: $selectedTimeframe) {
                    ForEach(timeframes, id: \..self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 40)
                
                Button(action: startSavingsPlan) {
                    Text("Start Savings Plan")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.9))
                        .foregroundColor(.purple)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 40)
                
                if savingsPlanStarted {
                    Text("Savings plan started for \(selectedTimeframe.lowercased())")
                        .foregroundColor(.white)
                        .padding()
                }
            }
        }
    }
    
    func startSavingsPlan() {
        savingsPlanStarted = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


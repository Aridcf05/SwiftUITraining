import SwiftUI

struct TaskCounterView: View {
    @StateObject private var viewModel = TaskCounterViewModel()
    
    var body: some View {
        VStack(spacing: 24) {
            Text("\(viewModel.count)")
                .font(.system(size: 50, weight: .bold))
                .accessibilityIdentifier("txt_counter_value") // Clave para XCUITest
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
                    .accessibilityIdentifier("txt_error_message")
            }
            
            HStack(spacing: 20) {
                Button("Restar") {
                    viewModel.decrement()
                }
                .accessibilityIdentifier("btn_decrement")
                
                Button("Sumar") {
                    viewModel.increment()
                }
                .accessibilityIdentifier("btn_increment")
            }
        }
        .padding()
    }
}

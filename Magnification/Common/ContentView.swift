import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @StateObject var manager = MagnificationManager()
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            MagnificationView()
                .navigationTitle("Magnification Effect")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        NavigationLink {
                            SettingsView()
                        } label: {
                            Image(systemName: "gear")
                        }
                    }
                }
        }
        .environmentObject(manager)
    }
}

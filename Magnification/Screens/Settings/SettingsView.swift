import SwiftUI

struct SettingsView: View {
    
    // MARK: - Properties
    @EnvironmentObject var manager: MagnificationManager
    
    // MARK: - Body
    var body: some View {
        List {
            
            // MARK: - Animation type Section
            Section("Animation type") {
                Picker("Current animation", selection: $manager.animationType) {
                    ForEach(MagnificationType.allCases, id: \.self) { type in
                        Text(type.rawValue)
                            .tag(type)
                    }
                }
            }
            
            // MARK: - Sphere Size Section
            if manager.animationType != .blackout {
                Section("Sphere Size") {
                    Slider(value: $manager.sphereSize, in: 100...200)
                    Text("\(Int(manager.sphereSize)) points")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            
            // MARK: - Gradient colors Section
            Section("Gradient colors") {
                ColorPicker("First color", selection: $manager.firstColor)
                ColorPicker("Second color", selection: $manager.secondColor)
                ColorPicker("Third color", selection: $manager.thirdColor)
            }
            
            // MARK: - Number of elements Section
            Section("Number of elements per section") {
                Slider(value: $manager.elementsInSection, in: 5...15)
                Text("\(Int(manager.elementsInSection)) pcs")
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .navigationTitle("Settings")
    }
}


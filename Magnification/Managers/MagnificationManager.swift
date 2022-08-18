import Foundation
import SwiftUI
import CoreGraphics

final class MagnificationManager: ObservableObject {
    
    // MARK: - Properties
    @Published var elementsInSection: Double = 10
    @Published var animationType: MagnificationType = .sphere
    @Published var detailValue: CGFloat = 1
    @Published var sphereSize: CGFloat = 150
    
    @Published var firstColor: Color = .red
    @Published var secondColor: Color = .blue
    @Published var thirdColor: Color = .green
    
    // MARK: - Public methods
    func getItemScale(location: CGPoint,
                      rect: CGRect,
                      size: CGSize) -> CGFloat {
        let a = location.x - rect.midX
        let b = location.y - rect.midY
        
        let root = sqrt((a * a) + (b * b))
        let diagonal = sqrt((size.width * size.width) + (size.height * size.height))
        
        var scale: CGFloat
        switch animationType {
        case .semisphere:
            scale = root / (diagonal / detailValue)
        case .sphere:
            scale = (root - sphereSize) / sphereSize
        case .blackout:
            scale = (root - sphereSize) / sphereSize
        }
        
        let returnScale = location == .zero ? 1 : (1 - scale)
        return returnScale > 0 ? returnScale : 0.001
    }
}

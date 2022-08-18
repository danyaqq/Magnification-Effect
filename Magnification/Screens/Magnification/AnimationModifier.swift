import Foundation
import SwiftUI

struct AnimationModifier: ViewModifier {
    
    // MARK: - Properties
    let type: MagnificationType
    let rect: CGRect
    let transformedRect: CGRect
    let location: CGPoint
    let transformedLocation: CGPoint
    
    // MARK: - Body
    func body(content: Content) -> some View {
        if type != .blackout {
            content
                .offset(x: (transformedRect.midX - rect.midX),
                        y: (transformedRect.midY - rect.midY))
                .offset(x: location.x - transformedLocation.x,
                        y: location.y - transformedLocation.y)
        } else {
            content
        }
    }
}


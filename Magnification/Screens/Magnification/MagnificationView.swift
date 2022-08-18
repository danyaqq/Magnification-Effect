import SwiftUI

private let COORDINATE_SPACE_NAME = "GESTURE"

struct MagnificationView: View {
    
    // MARK: Properties
    @EnvironmentObject private var manager: MagnificationManager
    @GestureState private var location: CGPoint = .zero
    
    // MARK: - Body
    var body: some View {
        
        // MARK: - Colors
        let colors = [manager.firstColor, manager.secondColor, manager.thirdColor]
        
        LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
            .mask {
                GeometryReader { proxy in
                    
                    // MARK: - Main Layout properties
                    let size = proxy.size
                    let gridItem = GridItem(.flexible(), spacing: 0)
                    let gridItems = Array(repeating: gridItem, count: Int(manager.elementsInSection))
                    let width = (size.width / CGFloat(manager.elementsInSection))
                    let totalItemsCount = Int(Double(size.height / width).rounded() * Double(manager.elementsInSection))
                    
                    LazyVGrid(columns: gridItems, spacing: 0) {
                        ForEach(0..<totalItemsCount, id: \.self) { _ in
                            MagnificationItem(globalSize: size)
                                .frame(height: width)
                        }
                    }
                }
                .padding()
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .updating($location, body: { value, out, _ in
                        out = value.location
                    })
            )
            .coordinateSpace(name: COORDINATE_SPACE_NAME)
            .animation(.easeInOut, value: location == .zero)
    }
}

// MARK: - Views
private extension MagnificationView {
    @ViewBuilder func MagnificationItem(globalSize: CGSize) -> some View {
        GeometryReader { innerProxy in
            
            // MARK: - Item Layout properties
            let rect = innerProxy.frame(in: .named(COORDINATE_SPACE_NAME))
            let scale = manager.getItemScale(location: location, rect: rect, size: globalSize)
            
            let transformedRect = rect.applying(.init(scaleX: scale, y: scale))
            let transformedLocation = location.applying(.init(scaleX: scale, y: scale))
            
            RoundedRectangle(cornerRadius: 4)
                .scaleEffect(scale)
                .padding(5)
                .modifier(
                    AnimationModifier(type: manager.animationType,
                                      rect: rect,
                                      transformedRect: transformedRect,
                                      location: location,
                                      transformedLocation: transformedLocation)
                )
        }
    }
}

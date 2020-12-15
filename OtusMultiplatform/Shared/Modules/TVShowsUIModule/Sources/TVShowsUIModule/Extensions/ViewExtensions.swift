import SwiftUI

struct FocusView: ViewModifier {
    
    @ViewBuilder
    func body(content: Content) -> some View {
        #if os(tvOS)
        content.focusable()
        #else
        content
        #endif
    }
}

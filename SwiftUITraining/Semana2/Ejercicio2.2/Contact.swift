    import Foundation

    struct Contact: Identifiable, Hashable {
        let id = UUID()
        let name: String
        let iconName: String
        let phone: String?
    }

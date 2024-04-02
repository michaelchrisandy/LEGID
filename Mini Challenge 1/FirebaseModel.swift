import SwiftUI
import Firebase

class FirebaseModel: ObservableObject {
    @Published var data: String = ""

    private var ref: DatabaseReference = Database.database().reference().child("yourFirebaseNode")

    init() {
        // Start observing changes in Firebase
        ref.observe(.value) { snapshot in
            if let value = snapshot.value as? String {
                DispatchQueue.main.async {
                    self.data = value
                }
            }
        }
    }
}

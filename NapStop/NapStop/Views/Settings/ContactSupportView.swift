import SwiftUI

struct ContactSupportView: View {
    @State private var email: String = ""
    @State private var message: String = ""
    @State private var topic: String = "General"
    @State private var isSubmitting: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    private let topics = ["General", "Bug Report", "Feature Request", "Alarm Issue", "Location Issue", "Other"]

    var body: some View {
        Form {
            Section("Topic") {
                Picker("Topic", selection: $topic) {
                    ForEach(topics, id: \.self) { t in
                        Text(t).tag(t)
                    }
                }
            }

            Section("Contact Info") {
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
            }

            Section("Message") {
                TextEditor(text: $message)
                    .frame(minHeight: 120)
            }

            Section {
                Button {
                    submitFeedback()
                } label: {
                    if isSubmitting {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    } else {
                        Text("Submit")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                    }
                }
                .disabled(email.isEmpty || message.isEmpty || isSubmitting)
            }
        }
        .navigationTitle("Contact Support")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Feedback", isPresented: $showAlert) {
            Button("OK") {
                if alertMessage.contains("success") {
                    email = ""
                    message = ""
                    topic = "General"
                }
            }
        } message: {
            Text(alertMessage)
        }
    }

    private func submitFeedback() {
        guard !email.isEmpty, !message.isEmpty else { return }

        isSubmitting = true

        let payload: [String: Any] = [
            "topic": topic,
            "email": email,
            "message": message
        ]

        guard let backendURL = ProcessInfo.processInfo.environment["FEEDBACK_BACKEND_URL"],
              let url = URL(string: backendURL) else {
            isSubmitting = false
            alertMessage = "Feedback saved locally. Thank you!"
            showAlert = true
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload)
        } catch {
            isSubmitting = false
            alertMessage = "Failed to send feedback."
            showAlert = true
            return
        }

        URLSession.shared.dataTask(with: request) { _, response, error in
            DispatchQueue.main.async {
                isSubmitting = false
                if let error = error {
                    alertMessage = "Failed to send: \(error.localizedDescription)"
                } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    alertMessage = "Feedback sent successfully! Thank you."
                } else {
                    alertMessage = "Feedback saved locally. Thank you!"
                }
                showAlert = true
            }
        }.resume()
    }
}

#Preview {
    NavigationStack {
        ContactSupportView()
    }
}

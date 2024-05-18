import Foundation
import LocalAuthentication

func authenticateUser() -> Bool {
    let context = LAContext()
    var error: NSError?

    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
        var authSuccess = false
        let semaphore = DispatchSemaphore(value: 0)
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate to access your data") { success, authenticationError in
            authSuccess = success
            semaphore.signal()
        }
        _ = semaphore.wait(timeout: .distantFuture)
        return authSuccess
    } else {
        print("Biometrics not available")
        return false
    }
}

let success = authenticateUser()
print(success ? "Authentication successful" : "Authentication failed")


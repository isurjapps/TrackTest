//
//  LoginScreenViewModel.swift
//  CarTrack
//
//  Created by Prashant Singh on 9/5/21.
//

import Foundation
import Combine
import CoreData
import UIKit

final class LoginScreenViewModel {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var users: [UserCredentials]?
    
    @Published var userEmail = ""
    @Published var loginPassword = ""
    
    let userEmailMessagePublisher = PassthroughSubject<String, Never>()
    let loginPasswordMessagePublisher = PassthroughSubject<String, Never>()
    
    var validatedEmail: AnyPublisher<String?, Never> {
        return $userEmail
            .map { email in
                if self.isValidEmail(emailID: email) == false {
                    return nil
                }
                self.userEmailMessagePublisher.send("")
                return email
        }
        .eraseToAnyPublisher()
    }

    var validatedPassword: AnyPublisher<String?, Never> {
        
        return $loginPassword
            .map { password in
                guard password.count > 5 else {
                    return nil
                }
                self.loginPasswordMessagePublisher.send("")
                return password
        }
        .eraseToAnyPublisher()
    }
    
    var validToProceed: AnyPublisher<(String, String)?, Never> {
        return Publishers.CombineLatest(validatedEmail, validatedPassword)
            .map { email, password in
                
                guard let email = email, let password = password else {
                    return nil
                }
                return (email, password)
        }
        .eraseToAnyPublisher()
    }

    func isValidEmail(emailID: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: emailID)
    }
    
    func validateLoginCredentials(userEmail: String, password: String) -> (Bool, Bool) {
        var userEmailIsValid: Bool = true
        var passwordIsValid: Bool = true
        
        do {
            let request = UserCredentials.fetchRequest() as NSFetchRequest<UserCredentials>
            let userToValidate = userEmail
            let predicate = NSPredicate(format: "userName == %@", userToValidate)
            request.predicate = predicate
            self.users = try context.fetch(request)
            
            if self.users?.count != 0 {
                userEmailIsValid = true
                let user = self.users![0]
                if user.password == password {
                    passwordIsValid = true
                } else {
                    passwordIsValid = false
                }
            } else {
                userEmailIsValid = false
            }
        } catch {
            print("Error: \(error)")
        }
        return (userEmailIsValid, passwordIsValid)
    }
}

//
//  Validations.swift
//  Tombll
//
//  Created by Yusuf Tekin on 8.06.2023.
//

import Foundation

/**
 The `ValidationType` enum:

 - `ValidationType` is an enumeration that defines different types of validations.
 - It includes cases for `Email`, `Password`, `CreditCard`, `IdentityNumber`, `Name`, `URL`, `PhoneNumber`, `PostalCode`, `IPv4Address`, and `ISBN`.
 - Each case represents a specific type of validation.

 */
public enum ValidationType {
    /**
     Validates the string as an email address.

     - Uses a regular expression pattern (`emailRegex`) to validate the email format.
     - Creates an `NSPredicate` with the regex pattern and evaluates the string using the predicate.
     - Returns `true` if the string matches the email format, `false` otherwise.
     */
    case Email

    /**
     Validates the string as a password.

     - Uses a regular expression pattern (`passwordRegex`) to validate the password format.
     - Creates an `NSPredicate` with the regex pattern and evaluates the string using the predicate.
     - Returns `true` if the string matches the password format, `false` otherwise.
     */
    case Password

    /**
     Validates the string as a credit card number.

     - Removes any non-digit characters from the string using the `replacingOccurrences(of:options:)` method with a regular expression.
     - Uses a regular expression pattern (`cardNumberRegex`) to validate the credit card number format.
     - Creates an `NSPredicate` with the regex pattern and evaluates the trimmed string using the predicate.
     - Performs the Luhn algorithm to validate the credit card number checksum.
     - Returns `true` if the string passes the format and checksum validation, `false` otherwise.
     */
    case CreditCard

    /**
     Validates the string as a Turkish identity number.

     - Removes any non-digit characters from the string using the `replacingOccurrences(of:options:)` method with a regular expression.
     - Checks if the trimmed string has exactly 11 digits. If not, returns `false`.
     - Performs the Turkish Identity Number validation by calculating the checksum digit based on the sum of the first 10 digits.
     - Returns `true` if the string passes the format and checksum validation, `false` otherwise.
     */
    case IdentityNumber

    /**
     Validates the string as a name.

     - Uses a regular expression pattern (`nameRegex`) to validate the name format.
     - Creates an `NSPredicate` with the regex pattern and evaluates the string using the predicate.
     - Returns `true` if the string matches the name format, `false` otherwise.
     */
    case Name

    /**
     Validates the string as a URL.

     - Implement your URL validation logic here.
     - Returns `true` if the string represents a valid URL, `false` otherwise.
     */
    case URL

    /**
     Validates the string as a phone number.

     - Implement your phone number validation logic here.
     - Returns `true` if the string represents a valid phone number, `false` otherwise.
     */
    case PhoneNumber

    /**
     Validates the string as a postal code.

     - Implement your postal code validation logic here.
     - Returns `true` if the string represents a valid postal code, `false` otherwise.
     */
    case PostalCode

    /**
     Validates the string as an IPv4 address.

     - Implement your IPv4 address validation logic here.
     - Returns `true` if the string represents a valid IPv4 address, `false` otherwise.
     */
    case IPv4Address

    /**
     Validates the string as an ISBN.

     - Implement your ISBN validation logic here.
     - Returns `true` if the string represents a valid ISBN, `false` otherwise.
     */
    case ISBN
}

public extension String {
    /**
     Validates the string for the specified validation type.

     - Parameter type: The `ValidationType` to perform the validation.
     - Returns: `true` if the string is valid for the specified validation type, `false` otherwise.

     Validation logic for each `ValidationType` case is implemented within this method.

     - `Email`:
        - Uses a regular expression pattern (`emailRegex`) to validate the email format.
        - Creates an `NSPredicate` with the regex pattern and evaluates the string using the predicate.
        - Returns `true` if the string matches the email format, `false` otherwise.

     - `Password`:
        - Uses a regular expression pattern (`passwordRegex`) to validate the password format.
        - Creates an `NSPredicate` with the regex pattern and evaluates the string using the predicate.
        - Returns `true` if the string matches the password format, `false` otherwise.

     - `CreditCard`:
        - Removes any non-digit characters from the string using the `replacingOccurrences(of:options:)` method with a regular expression.
        - Uses a regular expression pattern (`cardNumberRegex`) to validate the credit card number format.
        - Creates an `NSPredicate` with the regex pattern and evaluates the trimmed string using the predicate.
        - Performs the Luhn algorithm to validate the credit card number checksum.
        - Returns `true` if the string passes the format and checksum validation, `false` otherwise.

     - `IdentityNumber`:
        - Removes any non-digit characters from the string using the `replacingOccurrences(of:options:)` method with a regular expression.
        - Checks if the trimmed string has exactly 11 digits. If not, returns `false`.
        - Performs the Turkish Identity Number validation by calculating the checksum digit based on the sum of the first 10 digits.
        - Returns `true` if the string passes the format and checksum validation, `false` otherwise.

     - `Name`:
        - Uses a regular expression pattern (`nameRegex`) to validate the name format.
        - Creates an `NSPredicate` with the regex pattern and evaluates the string using the predicate.
        - Returns `true` if the string matches the name format, `false` otherwise.

     - `URL`:
        - Implement your URL validation logic here.
        - Returns `true` if the string represents a valid URL, `false` otherwise.

     - `PhoneNumber`:
        - Implement your phone number validation logic here.
        - Returns `true` if the string represents a valid phone number, `false` otherwise.

     - `PostalCode`:
        - Implement your postal code validation logic here.
        - Returns `true` if the string represents a valid postal code, `false` otherwise.

     - `IPv4Address`:
        - Implement your IPv4 address validation logic here.
        - Returns `true` if the string represents a valid IPv4 address, `false` otherwise.

     - `ISBN`:
        - Implement your ISBN validation logic here.
        - Returns `true` if the string represents a valid ISBN, `false` otherwise.
     */
    public func isValid(for type: ValidationType) -> Bool {
        switch type {
        case .Email:
            let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            return emailPredicate.evaluate(with: self)
        case .Password:
            let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
            let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
            return passwordPredicate.evaluate(with: self)
        case .CreditCard:
            let trimmedNumber = replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
            let cardNumberRegex = "^(\\d{13,19})$"
            let cardNumberPredicate = NSPredicate(format: "SELF MATCHES %@", cardNumberRegex)

            if !cardNumberPredicate.evaluate(with: trimmedNumber) {
                return false
            }

            let cardNumberArray = Array(trimmedNumber.reversed()).map { Int(String($0)) ?? 0 }
            var sum = 0
            for (index, digit) in cardNumberArray.enumerated() {
                if index % 2 == 1 {
                    let doubledDigit = digit * 2
                    sum += doubledDigit > 9 ? doubledDigit - 9 : doubledDigit
                } else {
                    sum += digit
                }
            }

            return sum % 10 == 0
        case .IdentityNumber:
            let trimmedNumber = replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
            guard trimmedNumber.count == 11 else {
                return false
            }

            let digits = trimmedNumber.map { Int(String($0)) ?? 0 }

            guard digits[0] != 0 else {
                return false
            }

            let sum = digits.prefix(10).enumerated().reduce(0) { result, enumeratedDigit in
                let (index, digit) = enumeratedDigit
                let multiplier = index % 2 == 0 ? 1 : 3
                return result + digit * multiplier
            }

            let checksumDigit = (sum % 10 == 0) ? 0 : (10 - (sum % 10))

            return digits[10] == checksumDigit
        case .Name:
            let nameRegex = "^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"
            let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
            return namePredicate.evaluate(with: self)
        case .URL:
            if let url = URL(string: self) {
                // Check if the URL scheme is valid (e.g., http, https, ftp)
                if let scheme = url.scheme, ["http", "https", "ftp"].contains(scheme.lowercased()) {
                    // Check if the host is not empty
                    if let host = url.host, !host.isEmpty {
                        return true
                    }
                }
            }
            return false
        case .PhoneNumber:
            let phoneNumberRegex = #"^\d{3}-\d{3}-\d{4}$"#
            let phoneNumberPredicate = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
            return phoneNumberPredicate.evaluate(with: self)
        case .PostalCode:
            let postalCodeRegex = #"^[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d$"#
            let postalCodePredicate = NSPredicate(format: "SELF MATCHES %@", postalCodeRegex)
            return postalCodePredicate.evaluate(with: self)
        case .IPv4Address:
            let ipv4Regex = #"^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$"#
            let range = NSRange(location: 0, length: utf16.count)
            let regex = try! NSRegularExpression(pattern: ipv4Regex)
            return regex.firstMatch(in: self, options: [], range: range) != nil
        case .ISBN:
            let isbnRegex = #"^\d{9}[\d|X]$|^\d{13}$"#
            let range = NSRange(location: 0, length: utf16.count)
            let regex = try! NSRegularExpression(pattern: isbnRegex)
            return regex.firstMatch(in: self, options: [], range: range) != nil
        }
    }
}


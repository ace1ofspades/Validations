# Validations

A utility class in Swift for performing various types of validations on strings.

## Usage

1. Import the `Validations` into your project.

2. Use the `isValid(for:)` method on a string to perform a validation for a specific `ValidationType`.

```swift
let email = "test@example.com"
if email.isValid(for: .Email) {
    print("Valid email")
} else {
    print("Invalid email")
}
```

## Validation Types
The ValidationType enum defines different types of validations that can be performed.

### Email
Validates the string as an email address.

### Password
Validates the string as a password.

### CreditCard
Validates the string as a credit card number.

### IdentityNumber
Validates the string as a Turkish identity number.

### Name
Validates the string as a name.

### URL
Validates the string as a URL.

### PhoneNumber
Validates the string as a phone number.

### PostalCode
Validates the string as a postal code.

### IPv4Address
Validates the string as an IPv4 address.

### ISBN
Validates the string as an ISBN.

Note: For the URL, PhoneNumber, PostalCode, IPv4Address, and ISBN validation types, you need to implement the specific validation logic inside the isValid(for:) method.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

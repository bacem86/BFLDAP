# BFLDAP

BFLDAP is a Swift library that provides easy integration with LDAP (Lightweight Directory Access Protocol) servers for fetching and searching contacts.

## Features

- **LDAP Connection Setup**: Configure your LDAP connection with customizable parameters.
- **Contact Search**: Easily search for LDAP contacts based on keywords.
- **Contact Retrieval**: Retrieve LDAP contacts and seamlessly integrate them into your application.

## Installation

You can integrate BFLDAP into your project using Swift Package Manager. In Xcode, follow these steps:

1. Go to "File" > "Swift Packages" > "Add Package Dependency."
2. Enter the repository URL: `https://github.com/yourusername/BFLDAP.git`

## Usage

```swift
import BFLDAP

let configuration = LDAPContactLoaderConfiguration(
    binddn: "your binddn here",
    password: "your password here",
    host: "your host ip here",
    scope: .SUBTREE,
    useTLS: false,
    base: "your base here"
)

let loader = LDAPContactLoader(configuration: configuration)

loader.limitation = 10

loader.connect { error in
    // Handle connection success or error
}

let keyWord = "search keyword"

loader.search(keyWord: keyWord) { contacts in
    // Handle search results
}

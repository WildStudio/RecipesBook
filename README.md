# The Recipe Puppy App for iPhone  


## General information
This repository contains the Technical Test for Apps Developer from Badi.


## Coding Style Guide

This code follows the [Ray Wenderlich Swift Style Guide](https://github.com/raywenderlich/swift-style-guide).


## Architecture

This project follows the MVVM (Model View ViewModel) architecture with repositories and use cases, at the presentation layer. ViewModel are where the view business logic is added. A ViewModel only communicates with repositories and view controllers. We are using the delegate pattern to communicate with view controllers and closures, reactive baiding can also be added as a future enhancement. Our Network and Model layer follow a modular approach so they can be reused. When referring to modules we are referring to the idea of a single package of code. Modules can be compiled on therir own..


## Testing

Testing is done with the help of protocols. Also both the network and model layer are unit tested and integration tests have been added. All test will be executed (including the frameworks when executing RecipePuppyTests target. Testing at presentation layer can be improved adding UI tests and some sort of integration tests. There's also left to do the CI setup.


## Branching Strategy

Branching strategy follows [GitFlow](https://datasift.github.io/gitflow/IntroducingGitFlow.html)


## Dependencies

This projects make use of the following dependencies through [Swift Package Manager](https://github.com/apple/swift-package-manager/tree/master/Documentation)

* [SDWebImage](https://github.com/SDWebImage/SDWebImage)

## Usage

In order to ran this app open RecipePuppy.xcworkspace, choose RecipePuppy scheme and press run (cmd+R) either with a test device or an iPhone simulator (Minimum deployment target is iOS13)

//
//  AlertConfigurationBuilder.swift
//  RecipePuppyTests
//
//  Created by wearemobilefirst on 05/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

@testable import RecipePuppy

class AlertConfigurationBuilder {

    public var title: String? = nil
    public var body = ""
    public var actions: [AlertConfiguration.Action] = []


    fileprivate func build() -> AlertConfiguration {
        return AlertConfiguration(
            title: title,
            body: body,
            actions: actions
        )
    }

}


extension AlertConfiguration {

    static func build(_ build: ((AlertConfigurationBuilder) -> Void)? = nil) -> AlertConfiguration {
        let builder = AlertConfigurationBuilder()
        build?(builder)
        return builder.build()
    }

}


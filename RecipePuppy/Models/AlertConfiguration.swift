//
//  AlertConfiguration.swift
//  RecipePuppy
//
//  Created by wearemobilefirst on 03/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation

public struct AlertConfiguration: Equatable {

    public enum Style {
        case `default`
        case cancel
        case destructive
    }

    public typealias Action = (title: String, style: Style, handler: (() -> Void)?)

    public let title: String?
    public let body: String?
    public let actions: [Action]


    public init(title: String? = nil, body: String, actions: [Action] = []) {
        self.title = title
        self.body = body
        self.actions = actions
    }


    public static func == (lhs: AlertConfiguration, rhs: AlertConfiguration) -> Bool {
        guard lhs.title == rhs.title,
            lhs.body == rhs.body,
            lhs.actions.count == rhs.actions.count
        else { return false }
        for (index, value) in lhs.actions.enumerated() {
            if value.title != rhs.actions[index].title || value.style != rhs.actions[index].style {
                return false
            }
        }
        return true
    }

}

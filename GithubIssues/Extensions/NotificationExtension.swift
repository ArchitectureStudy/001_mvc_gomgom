//
//  NotificationExtension.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 9..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let IssueRequestCompletedNotification = Notification.Name("IssueRequestCompleted")
    static let IssueDetailRequestCompletedNotification = Notification.Name("IssueDetailRequestCompleted")
    static let IssueDetailCommentsRequestCompletedNotification = Notification.Name("IssueDetailCommentsRequestCompleted")
}

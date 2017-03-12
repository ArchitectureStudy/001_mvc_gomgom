//
//  NotificationExtension.swift
//  GithubIssues
//
//  Created by Chang Gwi Lee on 2017. 1. 9..
//  Copyright © 2017년 AfreecaTV. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let IssueRequestCompletedNotification = Notification.Name("IssueListRequestCompleted")
    static let IssueDetailRequestCompletedNotification = Notification.Name("IssueDetailRequestCompleted")
    static let IssueDetailCommentsRequestCompletedNotification = Notification.Name("IssueDetailCommentsRequestCompleted")
    static let IssueWriteCommentsRequestCompletedNotification = Notification.Name("IssueWriteCommentsRequestCompleted")
    
    static let IssueListRequestCompletedNotification = Notification.Name("IssueListRequestCompleted")
}


extension Notification.Name {
    struct Model {
        static let listsRequestComplete: Notification.Name = Notification.Name("IssueListsModelRequestCompleted")
        static let detailRequestComplete: Notification.Name = Notification.Name("IssueDetailModelRequestCompleted")
        static let detailCommentsRequestComplete: Notification.Name = Notification.Name("IssueDetailCommentsModelRequestCompleted")
        static let detailCommentWriteRequestComplete: Notification.Name = Notification.Name("IssueWriteCommentsModelRequestCompleted")
    }
    
    struct Interactor {
        static let listsRequestComplete: Notification.Name = Notification.Name("IssueListsInteractorRequestCompleted")
        static let detailRequestComplete: Notification.Name = Notification.Name("IssueDetailInteractorRequestCompleted")
        static let detailCommentsRequestComplete: Notification.Name = Notification.Name("IssueDetailCommentsInteractorRequestCompleted")
        static let detailCommentWriteRequestComplete: Notification.Name = Notification.Name("IssueWriteCommentsInteractorRequestCompleted")
    }
}

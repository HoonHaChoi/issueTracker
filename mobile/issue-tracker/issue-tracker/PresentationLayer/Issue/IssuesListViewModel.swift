//
//  IssuesListViewModel.swift
//  issue-tracker
//
//  Created by HOONHA CHOI on 2021/07/02.
//

import Foundation
import Combine

protocol IssueListProvider {
    func fetchIssueList()
}

final class IssueListViewModel: IssueListProvider {

    private var issuesUseCase: IssuesUseCase
    private var endpoint: EndPointGenerator
    private var cancellable = Set<AnyCancellable>()

    var errorHandler: ((NetworkError) -> Void)?
    var issues: (([Issue]) -> Void)?

    init(issuesUseCase: IssuesUseCase = IssueRepository(),
         endpoint: EndPointGenerator = EndPoint()) {
        self.issuesUseCase = issuesUseCase
        self.endpoint = endpoint
    }

    func fetchIssueList() {
        issuesUseCase.requestIssues(url: endpoint.url(router: .issues),
                                    session: .shared)
            .sink { [weak self] (complete) in
                if case .failure(let error) = complete {
                    self?.errorHandler?(error)
                }
            } receiveValue: { [weak self] (issueList) in
                self?.issues?(issueList.issues)
            }.store(in: &cancellable)
    }
}

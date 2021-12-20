//
//  FilterService.swift
//  project-iOS-desafio03
//
//  Created by MATHEUS DE ASSIS CARVALHO on 17/12/21.
//

import RxRelay

public final class FilterService {
    
    public static var shared = FilterService()
    
    var sorting: GithubService.Sorting?
    var order = GithubService.Order.desc
    
    private init() {}
    
    func reset() {
        self.sorting = nil
        self.order = .desc
    }
}

//
//  HabitCreateViewModel.swift
//  HabitsTracker
//
//  Created by KsArT on 27.03.2025.
//

import Foundation

final class HabitCreateViewModel: ObservableObject {
    private let repository: HabitRepository
    
    @Published var cardTitle: String = ""
    
    init(repository: HabitRepository) {
        self.repository = repository
    }
}

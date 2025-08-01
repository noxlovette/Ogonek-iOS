    //
    //  Alias+Task.swift
    //  Ogonek
    //
    //  Created by Danila Volkov on 31.07.2025.
    //

import Foundation

typealias TaskWithFiles = Components.Schemas.TaskWithFilesResponse
typealias TaskUpdate = Components.Schemas.TaskUpdate
typealias TaskFull = Components.Schemas.TaskFull
typealias File = Components.Schemas.FileSmall

typealias TaskSmall = Components.Schemas.TaskSmall

typealias PaginatedTasks = Components.Schemas.PaginatedTasks
typealias BadgeWrapperTasks = Components.Schemas.BadgeWrapperTasks

extension File: Identifiable {
}

import Foundation

class DeckListViewModel: BaseViewModel {
    var decks: [DeckSmall] = []

    var currentPage: Int32 = 1
    var hasMorePages = true
    var searchText = ""

    @MainActor
    func loadDecks() async {
        isLoading = true
        errorMessage = nil

        do {
            if
                isPreview
            {
                decks = MockData.decks.data
            } else {
                let paginatedDecks = try await apiService.listDecks(
                    page: currentPage,
                    perPage: 20,
                    search: searchText,
                )

                decks = paginatedDecks.data
            }
        } catch {
            errorMessage = "Failed to load Decks: \(error.localizedDescription)"
            print("Error loading Decks: \(error)")
        }

        isLoading = false
    }

    @MainActor
    func searchDecks(query: String) async {
        searchText = query
        currentPage = 1
        hasMorePages = true
        await loadDecks()
    }

    @MainActor
    func refreshDecks() async {
        currentPage = 1
        hasMorePages = true
        await loadDecks()
    }
}

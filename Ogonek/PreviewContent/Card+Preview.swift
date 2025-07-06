import Foundation

extension Card {
    static var preview: Card {
        previewSet.first!
    }

    static var previewSet: [Card] {
        [
            Card(id: "1", front: "Hello", back: "Привет", mediaUrl: "", deckId: "preview", createdAt: Date()),
            Card(id: "2", front: "Goodbye", back: "До свидания", mediaUrl: nil, deckId: "preview", createdAt: Date()),
            Card(id: "3", front: "Please", back: "Пожалуйста", mediaUrl: nil, deckId: "preview", createdAt: Date()),
            Card(id: "4", front: "Thank you", back: "Спасибо", mediaUrl: nil, deckId: "preview", createdAt: Date()),
            Card(id: "5", front: "Yes", back: "Да", mediaUrl: nil, deckId: "preview", createdAt: Date()),
            Card(id: "6", front: "No", back: "Нет", mediaUrl: nil, deckId: "preview", createdAt: Date()),
            Card(id: "7", front: "How are you?", back: "Как дела?", mediaUrl: nil, deckId: "preview", createdAt: Date()),
            Card(id: "8", front: "I’m fine", back: "Я в порядке", mediaUrl: nil, deckId: "preview", createdAt: Date()),
            Card(id: "9", front: "Excuse me", back: "Извините", mediaUrl: nil, deckId: "preview", createdAt: Date()),
            Card(id: "10", front: "What’s your name?", back: "Как тебя зовут?", mediaUrl: nil, deckId: "preview", createdAt: Date()),
        ]
    }
}

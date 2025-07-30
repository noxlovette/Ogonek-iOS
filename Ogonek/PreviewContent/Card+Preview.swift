import Foundation

extension Card {
    static var preview: Card {
        previewSet.first!
    }

    static var previewSet: [Card] {
        [
            Card(
                back: "Привет",
                createdAt: Date(),
                deckId: "preview",
                front: "Hello",
                id: "1",
                mediaUrl: nil
            ),
            Card(
                back: "До свидания",
                createdAt: Date(),
                deckId: "preview",
                front: "Goodbye",
                id: "2",
                mediaUrl: nil
            ),
            Card(
                back: "Пожалуйста",
                createdAt: Date(),
                deckId: "preview",
                front: "Please",
                id: "3",
                mediaUrl: nil
            ),
            Card(
                back: "Спасибо",
                createdAt: Date(),
                deckId: "preview",
                front: "Thank you",
                id: "4",
                mediaUrl: nil
            ),
            Card(
                back: "Да",
                createdAt: Date(),
                deckId: "preview",
                front: "Yes",
                id: "5",
                mediaUrl: nil
            ),
            Card(
                back: "Нет",
                createdAt: Date(),
                deckId: "preview",
                front: "No",
                id: "6",
                mediaUrl: nil
            ),
            Card(
                back: "Как дела?",
                createdAt: Date(),
                deckId: "preview",
                front: "How are you?",
                id: "7",
                mediaUrl: nil
            ),
            Card(
                back: "Я в порядке",
                createdAt: Date(),
                deckId: "preview",
                front: "I'm fine",
                id: "8",
                mediaUrl: nil
            ),
            Card(
                back: "Извините",
                createdAt: Date(),
                deckId: "preview",
                front: "Excuse me",
                id: "9",
                mediaUrl: nil
            ),
            Card(
                back: "Как тебя зовут?",
                createdAt: Date(),
                deckId: "preview",
                front: "What's your name?",
                id: "10",
                mediaUrl: nil
            )
        ]
    }
}

//
//  Lesson+Preview.swift
//  Ogonek
//
//  Created by Danila Volkov on 29.04.2025.
//

import Foundation

extension Lesson {
    static var preview: Lesson {
        let lesson = Lesson(
            id: "Bc3JW7pm1Zh450ty95fAI",
            title: "Svatko 22.12.2024",
            topic: "Weak",
            markdown: "# Performance\n## Strengths\n- urgently - good vocabulary\n- the purpose PDF - that was perfect\n- great vocabulary work with extreme adjectives\n- workplace - even though you said 'jobplaces', it's great that you attempt to mix words! this is very English\n## Weaknesses\n- please do not use language models or translators to do **all** your writing work. it's a good idea to translate or ask them to translate **some** fixed expressions, though\n\n---\n# Input\n## Pronunciation\n- urgently\n- read in the past\n## Grammar\n- I don't know where her pictures are\n- you cannot use continuous tenses with frequencies\n- -self - the object is the same as the subject \n## Vocabulary\n- something stops working\n- are you agree - doesn't exist. 'agree' is not an adjective! it's a verb!",
            createdAt: Date(timeIntervalSinceNow: -1000),
            updatedAt: Date(timeIntervalSinceNow: -500),
        )
        return lesson
    }
}

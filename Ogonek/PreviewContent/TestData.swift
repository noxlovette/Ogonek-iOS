//
//  TestData.swift
//  Ogonek Swift
//
//  Created by Danila Volkov on 29.04.2025.
//

import Foundation

// MARK: LESSONS
let testLessonsData: Data = #"""
{
    "data": [
        {
            "id": "Bc3JW7pm1Zh450ty95fAI",
            "title": "Svatko 22.12.2024",
            "topic": "Weak",
            "markdown": "# Performance\n## Strengths\n- urgently - good vocabulary\n- the purpose PDF - that was perfect\n- great vocabulary work with extreme adjectives\n- workplace - even though you said 'jobplaces', it's great that you attempt to mix words! this is very English\n## Weaknesses\n- please do not use language models or translators to do **all** your writing work. it's a good idea to translate or ask them to translate **some** fixed expressions, though\n\n---\n# Input\n## Pronunciation\n- urgently\n- read in the past\n## Grammar\n- I don't know where her pictures are\n- you cannot use continuous tenses with frequencies\n- -self - the object is the same as the subject \n## Vocabulary\n- something stops working\n- are you agree - doesn't exist. 'agree' is not an adjective! it's a verb!",
            "createdAt": "2025-04-29T10:13:23.919399Z",
            "updatedAt": "2025-04-29T10:13:35.821358Z"
        },
        {
            "id": "u-76Z6IBd60iWml01W6Lw",
            "title": "Oleg 26.04.2025",
            "topic": "Acoustics",
            "markdown": "## [Pronunciation](https://forvo.com)\n- exhale when using the schwa sound – if you ever forget what it's like, say 'красивой' – that lazy sound at the end **is** the schwa sound\n- steadily\n- pierce – compare with 'purse' – we talked about both sounds in the lesson\n## Language\n\n| **Phrase**                 | **Topic**            | Notes                                                                       |\n| -------------------------- | -------------------- | --------------------------------------------------------------------------- |\n| this room assumed to be    | word choice          | this room was supposed to be. compare with 'I assume that you are mistaken' |\n| I still don't regret about | regret that purchase | more natural                                                                |\n| fulfilled by English words | full of/inundated    | fulfil a promise                                                            |\n### Formal vs Informal\nabstract nouns \nquestions and\nsentence length exclamation marks\nand structure colloquial expressions\npersonal examples first person.\n### Corrections\n| **Meow**                        | **Corrected**         | Notes                                                        |\n| ------------------------------- | --------------------- | ------------------------------------------------------------ |\n| I felt irritation               | I felt irritated      | feel + adj                                                   |\n| write something down in my note | notebook              | word choice                                                  |\n| when this terms became popular  | these                 | pronunciation – the short i vs the long i!                   |\n| the meaning pretty differ       | they differ very much | word choice, word position                                   |\n| languages are dying by itself   | on **their** own      | word choice, plurality                                       |\n| less formal nouns               | fewer nouns           | little/less is for uncountables, few/fewer is for countables |\n",
            "createdAt": "2025-04-29T10:11:36.378463Z",
            "updatedAt": "2025-04-29T10:11:53.137436Z"
        },
        {
            "id": "yjPqIZfNl-qFbLeIwv9Na",
            "title": "Griso 28.04.2025",
            "topic": "Einführung",
            "markdown": "## Aussprache\n- schön\n- Architektur\n\n## Sprache\n\n| **Phrase**                | **Topic**  | Notes                                                   |\n| ------------------------- | ---------- | ------------------------------------------------------- |\n| frohe Kinder              | Worbildung | froh, freuen                                            |\n| das kommt mir bekannt vor | fixed      | this looks familiar (besser als \"ich erinnere mich an\") |\n\n## SCHREIBEN\n### die eigene Meinung ausdrücken\nMeiner Meinung nach ...\nIch finde / denke / meine / glaube, dass ...\nIch finde es gut / schlecht, wenn\nIch frage mich, ob ...\n\n### Vor- und Nachteile nennen\nEin Vorteil / Nachteil von ... ist, dass • ...\nPositiv / Negativ an ... ist, dass ...\nDafür / Dagegen spricht ...\n\nEINFührung\nVOR NACH (Beispiele, zwei max)\nSCHLUSS\n\n### add\nTitel (der);название\ndas Gebäude;здание\nder Zoo;произношение ЦУ\nder Hammer (das wird bestimmt ein Hammer);это будет пушка\nGedächtnis (das);\n",
            "createdAt": "2025-04-29T10:09:07.053782Z",
            "updatedAt": "2025-04-29T10:11:33.910742Z"
        }
    ],
    "total": 3,
    "page": 1,
    "perPage": 20
}

"""#.data(using: .utf8)!

// MARK: TASKS
let testTasksData: Data = #"""
{
  "data": [
    {
      "id": "1A2B3C",
      "title": "Math Homework",
      "priority": 3,
      "completed": false,
      "dueDate": "2025-07-01T14:00:00.000Z",
      "markdown": "Review chapter 5 and solve problems 1-10.",
      "createdAt": "2025-06-20T09:00:00.000Z",
      "updatedAt": "2025-06-25T10:00:00.000Z"
    },
    {
      "id": "4D5E6F",
      "title": "Science Project",
      "priority": 5,
      "completed": false,
      "dueDate": "2025-07-10T17:00:00.000Z",
      "markdown": "Build a model volcano.",
      "createdAt": "2025-06-18T13:30:00.000Z",
      "updatedAt": "2025-06-23T16:00:00.000Z"
    },
    {
      "id": "7G8H9I",
      "title": "History Essay",
      "priority": 2,
      "completed": true,
      "dueDate": "2025-06-27T12:00:00.000Z",
      "markdown": "Discuss causes of WWI.",
      "createdAt": "2025-06-10T10:45:00.000Z",
      "updatedAt": "2025-06-24T11:30:00.000Z"
    },
    {
      "id": "J1K2L3",
      "title": "Biology Quiz Prep",
      "priority": 1,
      "completed": false,
      "dueDate": null,
      "markdown": "",
      "createdAt": "2025-06-15T08:15:00.000Z",
      "updatedAt": "2025-06-21T09:20:00.000Z"
    },
    {
      "id": "M4N5O6",
      "title": "Chemistry Lab Report",
      "priority": 4,
      "completed": false,
      "dueDate": "2025-07-03T09:00:00.000Z",
      "markdown": "Document findings on chemical reactions.",
      "createdAt": "2025-06-22T10:00:00.000Z",
      "updatedAt": "2025-06-26T15:00:00.000Z"
    },
    {
      "id": "P7Q8R9",
      "title": "English Presentation",
      "priority": 2,
      "completed": false,
      "dueDate": "2025-07-05T11:00:00.000Z",
      "markdown": "Topic: Shakespeare's influence on modern literature.",
      "createdAt": "2025-06-19T14:00:00.000Z",
      "updatedAt": "2025-06-25T14:30:00.000Z"
    },
    {
      "id": "S0T1U2",
      "title": "Computer Science Coding Task",
      "priority": 5,
      "completed": true,
      "dueDate": "2025-06-28T23:59:59.000Z",
      "markdown": "Implement a basic to-do list app in Swift.",
      "createdAt": "2025-06-17T13:00:00.000Z",
      "updatedAt": "2025-06-27T20:00:00.000Z"
    },
    {
      "id": "V3W4X5",
      "title": "Geography Map Drawing",
      "priority": 1,
      "completed": false,
      "dueDate": null,
      "markdown": "Draw political map of Europe.",
      "createdAt": "2025-06-20T12:00:00.000Z",
      "updatedAt": "2025-06-24T12:45:00.000Z"
    },
    {
      "id": "Y6Z7A8",
      "title": "Philosophy Reading",
      "priority": 2,
      "completed": false,
      "dueDate": "2025-07-07T18:00:00.000Z",
      "markdown": "Read and summarize Descartes' *Meditations*.",
      "createdAt": "2025-06-21T09:45:00.000Z",
      "updatedAt": "2025-06-27T10:30:00.000Z"
    },
    {
      "id": "B9C0D1",
      "title": "Art Sketchbook",
      "priority": 3,
      "completed": false,
      "dueDate": "2025-07-02T10:00:00.000Z",
      "markdown": "Sketch 3 still-life compositions.",
      "createdAt": "2025-06-23T11:15:00.000Z",
      "updatedAt": "2025-06-26T11:45:00.000Z"
    },
    {
      "id": "E2F3G4",
      "title": "PE Reflection Log",
      "priority": 1,
      "completed": true,
      "dueDate": null,
      "markdown": "Write weekly reflections on physical activity.",
      "createdAt": "2025-06-14T08:00:00.000Z",
      "updatedAt": "2025-06-20T09:30:00.000Z"
    },
    {
      "id": "H5I6J7",
      "title": "Economics Research",
      "priority": 4,
      "completed": false,
      "dueDate": "2025-07-08T16:00:00.000Z",
      "markdown": "Analyze impact of inflation on savings.",
      "createdAt": "2025-06-24T14:20:00.000Z",
      "updatedAt": "2025-06-27T13:00:00.000Z"
    }
  ],
  "total": 12,
  "page": 1,
  "perPage": 20
}
"""#.data(using: .utf8)!

// MARK: DECKS
let testDeckData: Data = #"""
[
    {
        "id": "k5YPQxlPcKxBoGoEMLvzt",
        "name": "New Deck",
        "description": "Your New Deck",
        "visibility": "assigned",
        "isSubscribed": false,
        "seen": true,
        "assigneeName": "Alice"
    },
    {
        "id": "8Wlaz7zU9_z0pGo183xnm",
        "name": "New Deck",
        "description": "New deck",
        "visibility": "assigned",
        "isSubscribed": false,
        "seen": false,
        "assigneeName": "Bob"
    },
    {
        "id": "Z50aPlw7Ld2iuklYoOb8H",
        "name": "Telegram?",
        "description": "Your New Deck",
        "visibility": "assigned",
        "isSubscribed": false,
        "seen": null,
        "assigneeName": null
    },
    {
        "id": "nqtS_Z8qaTVhlULchAlSl",
        "name": "New Deck",
        "description": "Your New Deck",
        "visibility": "private",
        "isSubscribed": false
    },
    {
        "id": "hz5yi0cmxa0DjoSi14hP9",
        "name": "New Deck",
        "description": "Your New Deck",
        "visibility": "assigned",
        "isSubscribed": true,
        "seen": true,
        "assigneeName": "Charlie"
    }
]
"""#.data(using: .utf8)!

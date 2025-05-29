import random

questions = [
    {
        "question": "What is the capital of France?",
        "options": ["a) Berlin", "b) Madrid", "c) Paris", "d) Rome"],
        "answer": "c"
    },
    {
        "question": "Which planet is known as the Red Planet?",
        "options": ["a) Earth", "b) Mars", "c) Jupiter", "d) Venus"],
        "answer": "b"
    },
    {
        "question": "Who wrote 'Romeo and Juliet'?",
        "options": ["a) Charles Dickens", "b) Mark Twain", "c) William Shakespeare", "d) J.K. Rowling"],
        "answer": "c"
    },
    {
        "question": "Which language is primarily used for web development?",
        "options": ["a) Python", "b) JavaScript", "c) C++", "d) Swift"],
        "answer": "b"
    },
    {
        "question": "What is the largest mammal on Earth?",
        "options": ["a) Elephant", "b) Blue Whale", "c) Giraffe", "d) Hippopotamus"],
        "answer": "b"
    },
    {
        "question": "What is the square root of 81?",
        "options": ["a) 7", "b) 8", "c) 9", "d) 10"],
        "answer": "c"
    },
    {
        "question": "Which continent is the Sahara Desert located in?",
        "options": ["a) Asia", "b) Africa", "c) Australia", "d) South America"],
        "answer": "b"
    },
    {
        "question": "How many days are there in a leap year?",
        "options": ["a) 364", "b) 365", "c) 366", "d) 367"],
        "answer": "c"
    },
    {
        "question": "Which element has the chemical symbol 'O'?",
        "options": ["a) Gold", "b) Oxygen", "c) Osmium", "d) Iron"],
        "answer": "b"
    },
    {
        "question": "Which instrument has keys, pedals, and strings?",
        "options": ["a) Violin", "b) Flute", "c) Guitar", "d) Piano"],
        "answer": "d"
    }
]

def run_quiz():
    name = input("Enter your name: ")
    score = 0

    print(f"\nWelcome, {name}! Let's start the quiz.\n")
    random.shuffle(questions)

    question_number = 1
    for q in questions:
        print(f"Q{question_number}: {q['question']}")
        for option in q["options"]:
            print(option)
        answer = input("Your answer (a/b/c/d): ").lower()

        if answer == q["answer"]:
            print("Correct!\n")
            score += 1
        else:
            print(f" Wrong! Correct answer was: {q['answer']}\n")

        question_number += 1  # manually increase counter

    print(f"{name}, you got {score} out of {len(questions)} correct.")

    with open("scores.txt", "a") as file:
        file.write(f"{name}: {score}/{len(questions)}\n")

    print("Your score has been saved to scores.txt")

if __name__ == "__main__":
    run_quiz()

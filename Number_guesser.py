import random


random_int = random.randint(1, 20)

player_guess = ""
attempts = 1

while player_guess != random_int:
    player_guess = int(input("Enter a number: "))
    if player_guess == random_int:
        print("You chose correctly")
        print("Attempts made: ", attempts)
        break
    else:
        print("Guess again")
        attempts += 1

import random

answer = input("Do you want to roll (yes/no)?: ").lower()

goal = 32
player_score = 0

while answer == "yes":
    roll = random.randint(1, 6)
    player_score += roll
    print(f"You rolled a {roll}. Your total score is now {player_score}.")


    if player_score == goal:
        print("You randomly got the goal.")
        break
    elif player_score > goal:
        print("You didnt get the score")
        break
    else:

      answer = input("Do you want to roll again? (yes/no): ").lower()

print("Thanks for playing!")

def check_balance(balance):
    print(f"Your balance is: ${balance:.2f}")
    return balance

def deposit(balance):
    amount = float(input("Enter amount to deposit: "))
    if amount > 0:
        balance += amount
        print(f"Deposited ${amount:.2f}. New balance: ${balance:.2f}")
    else:
        print("Invalid deposit amount.")
    return balance

def withdraw(balance):
    amount = float(input("Enter amount to deposit: "))
    if amount <= 0:
        print("INvalid withdrawal amount")
    elif amount > balance:
        print("Insufficient funds.")
    else:
        balance -= amount
        print(f"Withdrew ${amount: .2f}. New Balance: ${balance:.f}")
    return balance

def exit_program():
    print("Goodbye!")
    exit()


def menu():
    print("\n====== ATM Menu ======")
    print("1. Check Balance")
    print("2. Deposit Money")
    print("3. Withdraw Money")
    print("4. Exit")

menu_actions = {
    "1": check_balance,
    "2": deposit,
    "3": withdraw,
    "4": exit_program
}

def main():
    balance = 1000.0

    while True:
        menu()
        choice = input("Choose an option(1-4):")
        action = menu_actions.get(choice)
        if action:
            balance = action(balance)
        else:
            print("Invalid choice. Please try again.")

if __name__ == "__main__":
    main()

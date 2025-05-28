def km_to_miles():
    km = float(input("Enter kilometers: "))
    print(f"{km} km = {km * 0.621:.2f} miles")

def miles_to_km():
    miles = float(input("Enter miles: "))
    print(f"{miles} miles = {miles / 0.621:.2f} km")

def celsius_to_fahrenheit():
    c = float(input("Enter Celsius: "))
    print(f"{c}°C = {(c * 9/5) + 32:.2f}°F")

def fahrenheit_to_celsius():
    f = float(input("Enter Fahrenheit: "))
    print(f"{f}°F = {(f - 32) * 5/9:.2f}°C")

def exit_program():
    print("Goodbye!")
    exit()

def menu():
    print("\nUnit Converter Menu:")
    print("1. Kilometers to Miles")
    print("2. Miles to Kilometers")
    print("3. Celsius to Fahrenheit")
    print("4. Fahrenheit to Celsius")
    print("5. Exit")

menu_actions = {
    "1": km_to_miles,
    "2": miles_to_km,
    "3": celsius_to_fahrenheit,
    "4": fahrenheit_to_celsius,
    "5": exit_program
}

def main():
    while True:
        menu()
        choice = input("Choose an option (1-5): ")
        action = menu_actions.get(choice)
        if action:
            action()  # now safe: no parameters required
        else:
            print("Invalid choice. Please try again.")

if __name__ == "__main__":
    main()

#include <iostream>
#include <fstream>
#include <iomanip>
using namespace std;

const int MAX_STUDENTS = 100;

struct Student {
    string name;
    double grade;
};

void addStudent(Student students[], int& count) {
    if (count >= MAX_STUDENTS) {
        cout << "Maximum number of students reached.\n";
        return;
    }
    cout << "Enter student name: ";
    cin >> students[count].name;
    cout << "Enter grade: ";
    cin >> students[count].grade;
    count++;
}

void printAll(const Student students[], int count) {
    cout << "\n--- All Students ---\n";
    for (int i = 0; i < count; ++i) {
        cout << setw(2) << i + 1 << ". "
             << "Name: " << students[i].name
             << ", Grade: " << students[i].grade << endl;
    }
}

void findStudent(const Student students[], int count) {
    string searchName;
    cout << "Enter name to search: ";
    cin >> searchName;
    bool found = false;
    for (int i = 0; i < count; ++i) {
        if (students[i].name == searchName) {
            cout << "Found: " << students[i].name
                 << " - Grade: " << students[i].grade << endl;
            found = true;
        }
    }
    if (!found) {
        cout << "Student not found.\n";
    }
}

void saveToFile(const Student students[], int count) {
    ofstream file("students.txt");
    for (int i = 0; i < count; ++i) {
        file << students[i].name << " " << students[i].grade << endl;
    }
    file.close();
    cout << "Saved to students.txt\n";
}

void loadFromFile(Student students[], int& count) {
    ifstream file("students.txt");
    count = 0;
    while (file >> students[count].name >> students[count].grade) {
        count++;
        if (count >= MAX_STUDENTS) break;
    }
    file.close();
    cout << "Loaded from students.txt\n";
}

void menu() {
    cout << "\nStudent Gradebook\n";
    cout << "1. Add student\n";
    cout << "2. Show all students\n";
    cout << "3. Find student by name\n";
    cout << "4. Save to file\n";
    cout << "5. Load from file\n";
    cout << "6. Exit\n";
    cout << "Choose option: ";
}

int main() {
    Student students[MAX_STUDENTS];
    int count = 0;
    int choice;

    do {
        menu();
        cin >> choice;
        switch (choice) {
            case 1: addStudent(students, count); break;
            case 2: printAll(students, count); break;
            case 3: findStudent(students, count); break;
            case 4: saveToFile(students, count); break;
            case 5: loadFromFile(students, count); break;
            case 6: cout << "Goodbye!\n"; break;
            default: cout << "Invalid choice!\n";
        }
    } while (choice != 6);

    return 0;
}

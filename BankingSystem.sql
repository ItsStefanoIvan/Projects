CREATE TABLE Customers
(
  customer_id INT PRIMARY KEY,
  first_name TEXT,
  last_name TEXT
);

CREATE TABLE Accounts 
(
  account_id INT PRIMARY KEY,
  customer_id INT,
  balance REAL CHECK (balance >= 0),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Transactions 
(
  transactions_id INT PRIMARY KEy,
  account_id INT,
  amount REAL,
  transactions_type TEXT CHECK (transactions_type IN ('deposit', 'withdraw')),
  transaction_date DATE,
  FOREIGN KEY(account_id) REFERENCES Accounts(account_id)
);

INSERT INTO Customers VALUES
(1, 'Ivan', 'Petrov'),
(2, 'Maria', 'Ivanova');

INSERT INTO Accounts VALUES
(101,1,1000.00),
(102,2,500.00);

INSERT INTO Transactions VALUES
(1, 101, 200.00, 'deposit', '2025-01-01'),
(2, 101, 100.00, 'withdraw', '2025-01-02'),
(3, 102, 50.00, 'withdraw', '2025-01-03');

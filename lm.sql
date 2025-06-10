-- Drop tables if they exist (for clean rerun)
DROP TABLE IF EXISTS BookAuthors;
DROP TABLE IF EXISTS Loans;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Authors;
DROP TABLE IF EXISTS Members;

-- Authors Table
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    UNIQUE(FirstName, LastName)
);

-- Books Table
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    PublishedYear YEAR,
    CopiesAvailable INT DEFAULT 1 CHECK (CopiesAvailable >= 0)
);

-- Members Table
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    DateJoined DATE NOT NULL DEFAULT CURRENT_TIMESTAMP

);

-- Loans Table (which member borrowed which book)
CREATE TABLE Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    LoanDate DATE NOT NULL DEFAULT CURRENT_DATE,
    ReturnDate DATE,
    CONSTRAINT fk_member FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    CONSTRAINT fk_book FOREIGN KEY (BookID) REFERENCES Books(BookID),
    CONSTRAINT chk_return_after_loan CHECK (ReturnDate IS NULL OR ReturnDate >= LoanDate)
);

-- Many-to-Many relationship table between Books and Authors
CREATE TABLE BookAuthors (
    BookID INT NOT NULL,
    AuthorID INT NOT NULL,
    PRIMARY KEY (BookID, AuthorID),
    CONSTRAINT fk_ba_book FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE,
    CONSTRAINT fk_ba_author FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE CASCADE
);

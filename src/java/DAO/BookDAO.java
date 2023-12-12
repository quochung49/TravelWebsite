package DAO;

import entity.model.Book;
import DB.DBConnect; // Assuming you have a database connection class
import entity.model.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {

    private final Connection connection;

    public BookDAO() {
        connection = DBConnect.getConn(); // Get a database connection
    }

    // Create a new book record
    public void addBook(Book book) {
        String sql = "INSERT INTO [Books] (Title, Author, Description, Price, QuantityInStock, ImageURL, CategoryID) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try ( PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, book.getTitle());
            statement.setString(2, book.getAuthor());
            statement.setString(3, book.getDescription());
            statement.setDouble(4, book.getPrice());
            statement.setInt(5, book.getQuantityInStock());
            statement.setString(6, book.getImageURL());
            statement.setInt(7, book.getCategory().getId()); // Set the CategoryID
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }
    }

    // Retrieve a list of all books from the database
    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.*, c.CategoryID, c.CategoryName FROM [Books] b "
                + "JOIN [Categories] c ON b.CategoryID = c.CategoryID";
        try ( PreparedStatement statement = connection.prepareStatement(sql);  ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                int id = resultSet.getInt("BookID");
                String title = resultSet.getString("Title");
                String author = resultSet.getString("Author");
                String description = resultSet.getString("Description");
                float price = resultSet.getFloat("Price");
                int quantityInStock = resultSet.getInt("QuantityInStock");
                String imageURL = resultSet.getString("ImageURL");

                int categoryId = resultSet.getInt("CategoryID");
                String categoryName = resultSet.getString("CategoryName");
                Category category = new Category(categoryId, categoryName);

                Book book = new Book(id, title, author, description, price, quantityInStock, imageURL);
                book.setCategory(category);

                books.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }
        return books;
    }

    public Book getBookById(int id) {
        Book book = null;
        String sql = "SELECT * FROM [Books] WHERE BookId = ?";
        try ( PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id); // Set the BookId parameter
            try ( ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    String title = resultSet.getString("Title");
                    String author = resultSet.getString("Author");
                    String description = resultSet.getString("Description");
                    float price = resultSet.getFloat("Price");
                    int quantityInStock = resultSet.getInt("QuantityInStock");
                    String imageURL = resultSet.getString("ImageURL");

                    int categoryId = resultSet.getInt("CategoryID");
                    Category category = new CategoryDAO().getCategoryById(categoryId);
                    book = new Book(id, title, author, description, price, quantityInStock, imageURL);
                    book.setCategory(category);

                }
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle the exception appropriately
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }
        return book;
    }

    // Update an existing book record
    public void updateBook(Book book) {
        String sql = "UPDATE [Books] SET Title=?, Author=?, Description=?, Price=?, QuantityInStock=?, ImageURL=? WHERE BookID=?";
        try ( PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, book.getTitle());
            statement.setString(2, book.getAuthor());
            statement.setString(3, book.getDescription());
            statement.setDouble(4, book.getPrice());
            statement.setInt(5, book.getQuantityInStock());
            statement.setString(6, book.getImageURL());
            statement.setInt(7, book.getId());
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }
    }

    // Delete a book record by ID
    public void deleteBook(int bookID) {
        String sql = "DELETE FROM [Books] WHERE BookID=?";
        try ( PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, bookID);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately
        }
    }

    public int getTotalBooks() {
        int totalBooks = 0;
        try {
            String query = "SELECT COUNT(*) AS totalBooks FROM [Books]";
            PreparedStatement stmt = connection.prepareStatement(query);
            ResultSet resultSet = stmt.executeQuery();

            if (resultSet.next()) {
                totalBooks = resultSet.getInt("totalBooks");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalBooks;
    }

    public int getLowQuantityBooks(int lowQuantityThreshold) {
        int totalBooks = 0;
        try {
            String query = "SELECT COUNT(*) AS totalBooks FROM [Books] WHERE QuantityInStock < ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, lowQuantityThreshold); // Set the threshold for low quantity
            ResultSet resultSet = stmt.executeQuery();

            if (resultSet.next()) {
                totalBooks = resultSet.getInt("totalBooks");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalBooks;
    }

    public int countSearchResult(String text) {
        int count = 0;
        try {
            String query = "SELECT COUNT(*) FROM [Books] WHERE Title LIKE ? OR Author LIKE ? OR Description LIKE ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            String searchText = "%" + text + "%";
            stmt.setString(1, searchText);
            stmt.setString(2, searchText);
            stmt.setString(3, searchText);
            ResultSet resultSet = stmt.executeQuery();

            if (resultSet.next()) {
                count = resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }

        return count;
    }

    public List<Book> searchBooks(String text) {
        List<Book> searchResults = new ArrayList<>();
        try {
            String query = "SELECT * FROM [Books] WHERE Title LIKE ? OR Author LIKE ? OR Description LIKE ?";
            PreparedStatement stmt = connection.prepareStatement(query);
            String searchText = "%" + text + "%";
            stmt.setString(1, searchText);
            stmt.setString(2, searchText);
            stmt.setString(3, searchText);

            ResultSet resultSet = stmt.executeQuery();

            while (resultSet.next()) {
                int bookId = resultSet.getInt("BookId");
                Book book = getBookById(bookId);
                searchResults.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return searchResults;
        }

        return searchResults;
    }

    public List<Book> getBooksByPage(int pageSize, int pageIndex) {
        List<Book> books = new ArrayList<>();
        try {
            int offset = (pageIndex - 1) * pageSize;
            PreparedStatement preparedStatement = connection.prepareStatement(
                    "SELECT * FROM [Books] ORDER BY BookID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
            );
            preparedStatement.setInt(1, offset);
            preparedStatement.setInt(2, pageSize);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                books.add(getBookById(rs.getInt("bookId")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return books;
        }
        return books;
    }

    public List<Book> getBooksByCatId(int categoryId) {
        List<Book> books = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(
                    "SELECT * FROM [Books] WHERE CategoryID=?"
            );
            preparedStatement.setInt(1, categoryId);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                books.add(getBookById(rs.getInt("bookId")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return books;
        }
        return books;
    }

    public List<Book> getBooksByPageAndCatID(int pageSize, int pageIndex, int categoryId) {
        List<Book> books = new ArrayList<>();
        try {
            int offset = (pageIndex - 1) * pageSize;
            PreparedStatement preparedStatement = connection.prepareStatement(
                    "SELECT * FROM [Books] WHERE CategoryID=? ORDER BY BookID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
            );
            preparedStatement.setInt(1, categoryId);
            preparedStatement.setInt(2, offset);
            preparedStatement.setInt(3, pageSize);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                books.add(getBookById(rs.getInt("bookId")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return books;
        }
        return books;
    }

}

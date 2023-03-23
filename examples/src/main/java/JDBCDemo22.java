import java.sql.*;


public class JDBCDemo22 {

    private static final String URL = "jdbc:mysql://localhost:3306/bookstore?useUnicode=yes&characterEncoding=UTF8&useSSL=false";
    private static final String USER = "test";
    private static final String PASSWORD = "test";

    private static boolean loadDriver() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            return true;
        } catch (ClassNotFoundException e) {
            System.out.println("Error loading JDBC Driver ");
            e.printStackTrace();
            return false;
        }
    }

    private static void insertAuthorWithAddressesTransactionally(Connection con) {

        String insertAuthorQuery = "insert into author values(?,?,?,?,?)";
        String insertAddressQuery = "insert into author_address values(?,?,?)";

        try (PreparedStatement stmtInsertAuthor = con.prepareStatement(insertAuthorQuery, Statement.RETURN_GENERATED_KEYS);
             PreparedStatement stmtInsertAddress1 = con.prepareStatement(insertAddressQuery);
             PreparedStatement stmtInsertAddress2 = con.prepareStatement(insertAddressQuery);
        ) {
            con.setAutoCommit(false);

            stmtInsertAuthor.setNull(1, Types.INTEGER);
            stmtInsertAuthor.setString(2, "������");
            stmtInsertAuthor.setString(3, "�������");
            stmtInsertAuthor.setString(4, null);
            stmtInsertAuthor.setDate(5, Date.valueOf("1960-7-1"));
            stmtInsertAuthor.executeUpdate();
            ResultSet generatedKeys = stmtInsertAuthor.getGeneratedKeys();
            int idAuthor = 0;
            if (generatedKeys.next()) {
                idAuthor = generatedKeys.getInt((1));
            } else {
                throw new SQLException("Creating Author failed, no ID obtained.");
            }

            stmtInsertAddress1.setNull(1, Types.INTEGER);
            stmtInsertAddress1.setInt(2, idAuthor);
            stmtInsertAddress1.setString(3, "fedorov@mail.ru");
            stmtInsertAddress1.executeUpdate();

            stmtInsertAddress2.setNull(1, Types.INTEGER);
            stmtInsertAddress2.setInt(2, idAuthor);
            stmtInsertAddress2.setString(3, "fedorov@gmail.com");
            stmtInsertAddress2.executeUpdate();

            con.commit();

        } catch (SQLException e) {
            try {
                con.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            e.printStackTrace();

        }
    }

    private static void getAuthorsWithAddressesByColNames(Connection con) {

        String selectQuery = "select *, email from author inner join author_address on authorid=author.id";
        System.out.println("Authors : ");
        try (PreparedStatement stmt = con.prepareStatement(selectQuery); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String firstName = rs.getString("firstName");
                String lastName = rs.getString("lastName");
                String patronymic = rs.getString("patronymic");
                Date birthDate = rs.getDate("birthdate");
                String email = rs.getString("email");
                System.out.println("id = " + id + " firstName = " + firstName +
                        " lastName = " + lastName + " patronymic = " + patronymic +
                        " birthDate = " + birthDate + " email = " + email);
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }
        System.out.println("End Authors");
    }


    public static void main(String args[]) {

        if (!loadDriver()) {
            return;
	}

        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {

            insertAuthorWithAddressesTransactionally(con);
            getAuthorsWithAddressesByColNames(con);

        } catch (SQLException sqlEx) {
            sqlEx.printStackTrace();
        }
    }

}
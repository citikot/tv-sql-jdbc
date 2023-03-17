import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Statement;

class Author {
    private int id;
    private String firstName;
    private String lastName;
    private String patronymicName;
    private Date birthDate;

    public Author(int id, String firstName, String lastName, String patronymicName, Date birthDate) {
        super();
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.patronymicName = patronymicName;
        this.birthDate = birthDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getPatronymicName() {
        return patronymicName;
    }

    public void setPatronymicName(String patronymicName) {
        this.patronymicName = patronymicName;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    @Override
    public String toString() {
        return "Author [id=" + id + ", firstName=" + firstName + ", lastName=" + lastName + ", patronymicName="
                + patronymicName + ", birthDate=" + birthDate + "]";
    }
}

public class JDBCDemo {

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

    private static void getAuthorsByColNames(Connection con) {

        String selectQuery = "select * from author";
        try (Statement stmt = con.createStatement(); ResultSet rs = stmt.executeQuery(selectQuery)) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String firstName = rs.getString("firstName");
                String lastName = rs.getString("lastName");
                String patronymic = rs.getString("patronymic");
                Date birthDate = rs.getDate("birthdate");
                Author author = new Author(id, firstName, lastName, patronymic, birthDate);
                System.out.println(author);
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }
    }

    private static void getAuthorsByColNumbers(Connection con) {

        String selectQuery = "select * from author";
        try (Statement stmt = con.createStatement(); ResultSet rs = stmt.executeQuery(selectQuery)) {

            while (rs.next()) {
                int id = rs.getInt(1);
                String firstName = rs.getString(2);
                String lastName = rs.getString(3);
                String patronymic = rs.getString(4);
                Date birthDate = rs.getDate(5);
                Author author = new Author(id, firstName, lastName, patronymic, birthDate);
                System.out.println(author);
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }
    }
    private static void insertAuthor(Connection con) {
        String insertQuery = "insert into author values(null,'������','�������',null,'1960-7-1')";
        int result;
        try (Statement stmt = con.createStatement()) {
            result = stmt.executeUpdate(insertQuery, Statement.RETURN_GENERATED_KEYS);
            if (result > 0) {
                System.out.println("Result = " + result);
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    int id = rs.getInt(1);
                    System.out.println("id = " + id);
                    rs.close();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    private static void updateAuthor(Connection con) {
        String updateQuery = "update author set firstname ='��������' where lastname='�������'";
        int result;
        try (Statement stmt = con.createStatement()) {
            result = stmt.executeUpdate(updateQuery);
            System.out.println("Result = " + result);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void deleteAuthor(Connection con) {
        String deleteQuery = "delete from author where lastname='�������'";
        int result;
        try (Statement stmt = con.createStatement()) {
            result = stmt.executeUpdate(deleteQuery);
            System.out.println("Result = " + result);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String args[]) {

        if (!loadDriver()) {
            return;
	}

        try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {

            System.out.println("Authors by column names");
            getAuthorsByColNames(con);

            System.out.println("Authors by column numbers");
            getAuthorsByColNumbers(con);

            insertAuthor(con);

            System.out.println("Authors by column names");
            getAuthorsByColNames(con);

            updateAuthor(con);
            System.out.println("Authors after update");
            getAuthorsByColNames(con);

            deleteAuthor(con);
            System.out.println("Authors after delete");
            getAuthorsByColNames(con);

        } catch (SQLException sqlEx) {
            sqlEx.printStackTrace();
        }
    }

}
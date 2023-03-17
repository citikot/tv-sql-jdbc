import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

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

public class SQLInjectionDemo {

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

	private static void deleteAuthor(Connection con, String query) {
			try (Statement stmt = con.createStatement()) {
				stmt.executeUpdate(query);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	public static void main(String args[]) {

		if (!loadDriver()) {
			return;
		}
		String deleteQuery = "delete from author where id = ";

		try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {

			getAuthorsByColNames(con);

		} catch (SQLException sqlEx) {
			sqlEx.printStackTrace();
		}

		String userId = "";
		System.out.println("������� ID ���������� ������������");
		try(Scanner scanner = new Scanner(System.in)) {
			userId = scanner.nextLine();
		}


		try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {

			String deleteString = deleteQuery + userId;
			deleteAuthor(con, deleteString);

			System.out.println("Authors by column names");
			getAuthorsByColNames(con);

		} catch (SQLException sqlEx) {
			sqlEx.printStackTrace();
		}
	}

}
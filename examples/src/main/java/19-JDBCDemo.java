import java.sql.*;


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

			getAuthorsWithAddressesByColNames(con);

		} catch (SQLException sqlEx) {
			sqlEx.printStackTrace();
		}
	}

}
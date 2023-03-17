import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

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

	private static void getCount(Connection con, String query) {

		try (Statement stmt = con.createStatement(); ResultSet rs = stmt.executeQuery(query)) {

			while (rs.next()) {
				int count = rs.getInt(1);
				System.out.println("Total number of authors in the table : " + count);
			}
		} catch (SQLException e) {
			e.printStackTrace();

		}
	}

	public static void main(String args[]) {

		if (!loadDriver()) {
			return;
		}
		String query = "select count(*) from author";

		try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {

			getCount(con, query);

		} catch (SQLException sqlEx) {
			sqlEx.printStackTrace();
		}
	}

}
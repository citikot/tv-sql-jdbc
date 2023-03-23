
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBCDemo12 {

    private static final String URL = "jdbc:mysql://localhost:3306/bookstore?useUnicode=yes&characterEncoding=UTF8&useSSL=false";
    private static final String USER = "test";
    private static final String PASSWORD = "test";

    public static void main(String args[]) {

        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("Error loading JDBC Driver ");
            e.printStackTrace();
            return;
        }
        String query = "select count(*) from author";

        try {
            con = DriverManager.getConnection(URL, USER, PASSWORD);

            stmt = con.createStatement();

             rs = stmt.executeQuery(query);

            while (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("Total number of authors in the table : " + count);
            }

        } catch (SQLException sqlEx) {
            sqlEx.printStackTrace();
        } finally {
            try {
                if(con != null) {
                    con.close();
		}
            } catch (SQLException se) {
                se.printStackTrace();
            }
            try {
                if(stmt != null) {
                    stmt.close();
		}
            } catch (SQLException se) {
                se.printStackTrace();
            }
            try {
                if(rs != null ) {
                    rs.close();
		}
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }

}
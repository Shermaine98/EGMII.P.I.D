package Database;

import java.sql.Connection;

/**
 *
 * @author Atayan
 * @author Lapidario
 * @author Sy
 * @author Nunez
 *
 */
public abstract class DBConnectionFactory {

    String url = "jdbc:mysql://127.0.0.1:3306/egmi";
    String username = "root";
    String password = "shermaine";

    public static DBConnectionFactory getInstance() {
        return new DBConnectionFactoryImpl();
    }

    public abstract Connection getConnection();
}

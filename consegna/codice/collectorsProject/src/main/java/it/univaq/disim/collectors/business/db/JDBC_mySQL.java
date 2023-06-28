package it.univaq.disim.collectors.business.db;

public class JDBC_mySQL {
	private static final String DB_NAME = "Collectors";
	private static final String PASSWORD = "collectorsPwd€123";
	private static final String APP_USERNAME = "collectorsUser";
	
	private static final String CONNECTION = "jdbc:mysql://localhost:3306/" + DB_NAME+ "?serverTimezone=Europe/Rome";
	/*private ConnectJDBC connection = new ConnectJDBC(CONNECTION, APP_USERNAME, PASSWORD);
	private Query_JDBC queryModule;
	
	public JDBC_mySQL(){
		try {
			queryModule = new Query_JDBC(connection.getConnection());
		} catch (DatabaseConnectionException e) {
			System.exit(0);
			e.printStackTrace();
		}
	}*/
	
	private static ConnectJDBC connection = null;
    private Query_JDBC query;

    public JDBC_mySQL() {
        try {
            if (connection == null) {
                connection = new ConnectJDBC(CONNECTION, APP_USERNAME, PASSWORD);
            }
            query = new Query_JDBC(connection.getConnection());
        } catch (DatabaseConnectionException e) {
            System.exit(0);
            e.printStackTrace();
        }
    }
	public Query_JDBC getImplementation() {
		return query;
		}
	
	public ConnectJDBC getConnection() {
		return connection;
	}

}
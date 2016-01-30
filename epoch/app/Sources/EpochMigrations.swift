enum EpochMigrations: Int, Migrations {
	case CreateUsers
	case InsertUsers

	var sql: [String] {
		switch self {
		case CreateUsers:
			return ["CREATE TABLE users (id SERIAL PRIMARY KEY, name TEXT NOT NULL)"]
		case InsertUsers:
				return [
					"INSERT INTO USERS (name) VALUES('Josh')",
					"INSERT INTO USERS (name) VALUES('Jason')",
					"INSERT INTO USERS (name) VALUES('Nick')"
				]
		}
	}
}

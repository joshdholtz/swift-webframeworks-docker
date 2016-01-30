enum EpochMigrations: Int, Migrations {
	case CreateUsers = 0
	case InsertUsers = 1

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

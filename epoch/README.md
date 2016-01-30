# Epoch Example
Uses `Epoch` web framework with `PostgreSQL`

## Fun Bits

### Migrations
Uses a `Migrations` protocol to manage which migrations have been run and which haven't.

#### Example usage

```swift
let info = Connection.Info(host: "epochdb", database: "postgres", port: 5432, user: "postgres", password: nil)
let conn = Connection(info)

do {
  try conn.open()
  try EpochMigrations.up(conn)
} catch {
}
```

```swift
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
```

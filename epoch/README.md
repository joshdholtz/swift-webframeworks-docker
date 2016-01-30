# Epoch Example
Run `Epoch` web framework with `PostgreSQL` in a self contained Docker container

## Setup
1. Install [Docker](https://docs.docker.com/engine/installation/)
2. Clone/fork repo
3. Run Epoch
  1. `cd epoch`
  2. `docker-compose build`
  3. `docker-compose up`
    - This rebuilds the project (by using `swift build`) and then runs the build
    - Rerun this command after making changes to the project
  4. Hit machine url on port 8080
    - ex: http://192.168.99.100:8080


## Fun Bits
- [Epoch web framework](https://github.com/Zewo/Epoch)
- [PostgreSQL database adapter](https://github.com/Zewo/PostgreSQL)
- The actual implementation - [main.swift](./app/Sources/main.swift)
- Manage migrations using `Migrations` protocol
  - The `Migrations` protocol - [Migrations.swift](./app/Sources/Migrations.swift)
  - The actual migrations - [EpochMigrations.swift](./app/Sources/EpochMigrations.swift)

## Things To Do Yet
- Create routes for POST, PUT, and DELETE
- Write a light ORM layer on top of `PostgreSQL`
- Use a connection pool because so bad right now using one connection for whole server

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

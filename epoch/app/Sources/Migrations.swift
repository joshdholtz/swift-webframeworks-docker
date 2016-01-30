import PostgreSQL

/// Protocol used for writing migrations
protocol Migrations: EnumerableEnum {
	var sql: [String] { get }
}

/// Functions used to run migrations
extension Migrations where RawValue == Int {

	/// Migration database up
	static func up(conn: Connection) throws {

		// Create migrations table if we haven't already created it
		try createTable(conn)

		// Query for last migration run
		let lastMigration: Int? = try conn.execute("SELECT * FROM migrations ORDER BY id asc")
			.flatMap {
				return $0["id"]?.integer
			}
			.last
		debug("Last migration: \(lastMigration)")

		// Filter out migrations that haven't been run yet
		let migrationsToRun = allValues()
			.flatMap{$0}
			.filter{
				guard let lastMigration = lastMigration else { return true }
				return $0.rawValue > lastMigration
			}

		// Run migrations that haven't been run
		debug("Migrations to run: \(migrationsToRun)")
		for migration in migrationsToRun {
			try migration.run(conn)
		}
	}

	/// Creates migrations table (if it hasn't already been created)
	private static func createTable(conn: Connection) throws {
		try conn.execute(
      "CREATE TABLE IF NOT EXISTS migrations (id INTEGER NOT NULL UNIQUE)"
    )
	}

	/// Runs individual migration and sets migration number into table
	func run(conn: Connection) throws {
		for s in sql {
			debug("Running: '\(s)'")
			try conn.execute(s)
		}
		try conn.execute(
			"INSERT INTO MIGRATIONS (id) VALUES($1)", parameters: self.rawValue
		)
	}
}

protocol EnumerableEnum: RawRepresentable {
  static func allValues() -> [Self]
}
extension EnumerableEnum where RawValue == Int {
  static func allValues() -> [Self] {
    var idx = 0
    return Array(AnyGenerator {
			let id = idx
			idx += 1
			return Self(rawValue: id)
		})
  }
}

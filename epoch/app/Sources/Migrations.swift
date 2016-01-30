import PostgreSQL

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

protocol Migrations: EnumerableEnum {
	var sql: [String] { get }
}

extension Migrations where RawValue == Int {

	static func up(conn: Connection) throws {
		try createTable(conn)

		let lastMigration: Int? = try conn.execute("SELECT * FROM migrations ORDER BY id asc")
			.flatMap {
				return $0["id"]?.integer
			}
			.last
		debug("Last migration: \(lastMigration)")

		let migrationsToRun = allValues()
			.flatMap{$0}
			.filter{
				guard let lastMigration = lastMigration else { return true }
				return $0.rawValue > lastMigration
			}

		debug("Migrations to run: \(migrationsToRun)")
		for migration in migrationsToRun {
			try migration.run(conn)
		}
	}

	private static func createTable(conn: Connection) throws {
		try conn.execute(
      "CREATE TABLE IF NOT EXISTS migrations (id INTEGER NOT NULL UNIQUE)"
    )
	}

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

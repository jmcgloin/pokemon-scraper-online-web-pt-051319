class Pokemon


	attr_accessor :id, :name, :type, :db, :hp

	def initialize(id:, name:, type:, db:, hp: 60)
		@id = id
		@name = name
		@type = type
		@db = db
		@hp = hp
	end

	def self.save(name, type, db, hp = 60)
		db.execute('INSERT INTO pokemon (name, type) VALUES (?,?);', name, type)
		id = db.execute('SELECT id FROM pokemon ORDER BY id LIMIT 1').flatten[0]
		self.new(
			name: name,
			type: type,
			db: db,
			id: id
		)
	end

	def self.find(id, db)
		row = db.execute('SELECT * FROM pokemon WHERE id = ?', id)[0]
		Pokemon.new(
			name: row[1],
			type: row[2],
			id: row[0],
			db: db,
			hp: row[3]
		)
	end

	def alter_hp(hp, db)
		self.hp = hp
		db.execute('UPDATE pokemon SET hp = ? WHERE  id = ?', self.hp, self.id)
	end
end

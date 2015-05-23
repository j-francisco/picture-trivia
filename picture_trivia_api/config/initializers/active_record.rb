module ActiveRecord
	class Relation
		# returns an ActiveRecord relation as an array of hashs 
		# rather than instantiating ActiveRecord objects
		def select_all
			self.connection.select_all(self.to_sql)
		end
	end
end
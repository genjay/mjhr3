class Cardtime < ActiveRecord::Base
	require 'CSV'

	def self.import(file)
	  CSV.foreach(file.path, headers: false) do |row|
			Cardtime.create(up_data: row)
	  end # end CSV.foreach
 
	end # end self.import(file)

end

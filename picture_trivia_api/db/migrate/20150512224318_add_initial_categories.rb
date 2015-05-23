class AddInitialCategories < ActiveRecord::Migration
  def change
  	names = [
  		"world", 
  		"north_america", 
  		"south_america",
  		"africa",
  		"asia",
  		"europe"
  	]

  	names.each do |n|
  		unless Category.where(name: n).exists?
  			c = Category.new
  			c.name = n 
  			c.save
  		end
  	end
  end
end

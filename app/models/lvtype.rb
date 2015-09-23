class Lvtype < ActiveRecord::Base
  has_many :lvlists, :dependent => :restrict_with_error 
end

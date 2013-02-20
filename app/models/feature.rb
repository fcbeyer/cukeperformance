class Feature < ActiveRecord::Base
	has_many :scenarios, :dependent => :destroy
	belongs_to :suite
	
end

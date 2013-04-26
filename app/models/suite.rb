class Suite < ActiveRecord::Base
	has_many :features, :dependent => :destroy
	
	validates_uniqueness_of :runstamp
	
	scope :exclude, where(:exclude => false)
	
end

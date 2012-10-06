class Feature < ActiveRecord::Base
	belongs_to :suite
	has_many :features, :dependent => :destroy
	
end

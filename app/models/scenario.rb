class Scenario < ActiveRecord::Base
  has_many :steps, :dependent => :destroy
	belongs_to :feature
end

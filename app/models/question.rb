class Question < ActiveRecord::Base
  
  has_many :answers, :dependent => :destroy
  belongs_to :exam
  accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
end

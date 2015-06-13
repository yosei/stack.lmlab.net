class Stack < ActiveRecord::Base
  belongs_to :user
  has_many :stacks_tags
end

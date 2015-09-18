class StacksTag < ActiveRecord::Base
  belongs_to :stack
  validates :name, uniqueness: { scope: :stack_id }
end

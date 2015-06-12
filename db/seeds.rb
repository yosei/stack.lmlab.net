# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


if Rails.env == "development"
  s1 = Stack.create(title:"xxをyyする方法", problem:"", solution:"", explanation:"")
  StacksTag.create(stack:s1,name: "ruby")
  StacksTag.create(stack:s1,name: "rails")
end

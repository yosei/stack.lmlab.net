# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


if Rails.env == "development"
  u = User.create(email: "test@lmlab.net", password: "secret123")
p1 = <<EOT
マークダウンが使えると嬉しいかも？

コードスニペット
```
alias rs="rails s -b 192.168.33.10"
```
画像表示例
![](/stacks/1/1)
![](/stacks/1/2)
![](/stacks/1/3)
EOT

s1 = <<EOT
テーブル。
<table>
  <tr>
    <th>A</th>
    <th>B</th>
    <th>C</th>
  </tr>
  <tr>
    <td>100,000</td>
    <td>200,000</td>
    <td>300,000</td>
  </tr>
</table>
EOT

e1 = <<EOT
- 箇条書き1
- 箇条書き2
- 箇条書き3
EOT

  pic1 = "#{Rails.root}/db/seeds_images/1.png"
  pic2 = "#{Rails.root}/db/seeds_images/2.png"
  pic3 = "#{Rails.root}/db/seeds_images/3.png"

  s1 = Stack.create(title:"レギュレーション", problem:p1, solution:s1, explanation:e1,user:u)
  s1.picture1 = File.read(pic1)
  s1.picture2 = File.read(pic2)
  s1.picture3 = File.read(pic3)
  s1.save
  StacksTag.create(stack:s1,name: "ruby")
  StacksTag.create(stack:s1,name: "rails")

  s2 = Stack.create(title:"zzができないときは", problem:"", solution:"", explanation:"",user:u)
  StacksTag.create(stack:s2,name: "ruby")
  StacksTag.create(stack:s2,name: "linux")

  30.times do |i|
    s = Stack.create(title:"#{i} + #{i} は", problem:"", solution:"", explanation:"",user:u)
    StacksTag.create(stack:s,name: "linux") if i % 2 == 0
  end

end

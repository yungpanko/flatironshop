users = [
  {name:"Pat", email:"pat@pat.com", password:"pat" },
  {name:"Jared", email:"jared@jared.com", password:"jared" },
  {name:"Quynh", email:"quynh@quynh.com", password:"quynh" },
  {name:"admin", email:"admin@admin.com", password:"admin", admin:true}
]

User.create(users)
puts "Created users"

categories = [
  {name: 'Clothing'},
  {name: 'Books'},
  {name: 'Electronics'}
]

Category.create(categories)
puts "Created categories"

items = [
  {name:'Dress', description:'Flowery and light.', price:50 , condition:'Very Good' , seller_id: User.find_by_name('Quynh').id, category_id: Category.find_by_name('Clothing').id},
  {name:'Bible', description:'Hard cover, lightly used.', price:10 , condition:'Good' , seller_id: User.find_by_name('Pat').id, category_id: Category.find_by_name('Books').id},
  {name:'iPad', description:'First edition.', price:100 , condition:'Good' , seller_id: User.find_by_name('Jared').id, category_id: Category.find_by_name('Electronics').id},
]

Item.create(items)
puts "Created items"

order = Order.new(buyer_id: User.find_by_name('Pat').id)
order.items << Item.find_by_name('Dress')
order.items << Item.find_by_name('Bible')
order.save

order = Order.new(buyer_id: User.find_by_name('Quynh').id)
order.items << Item.find_by_name('iPad')
order.save
puts "Created orders"

Review.create(item_id: Item.find_by_name('iPad').id, content:'Very good item. As described, fast shipping!', rating:4)
puts "Created a review for iPad."

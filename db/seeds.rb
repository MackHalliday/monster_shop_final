# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ItemOrder.destroy_all
Order.destroy_all
User.destroy_all
Review.destroy_all
Item.destroy_all
Merchant.destroy_all

bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
dunder = Merchant.create(name: "Dunder Mifflin Paper Co", address: '1725 Slough Ave.', city: 'Scranton', state: 'PA', zip: 18501)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
bike = bike_shop.items.create(name: "Red Bike", description: "Oldie, but goodie", price: 200, image: "https://i.pinimg.com/originals/9d/5f/29/9d5f29749894957753a9edd9e2358d8b.png", inventory: 10)
watch = bike_shop.items.create(name: "Watch", description: "It's OK.", price: 40, image: "https://cdn.shopify.com/s/files/1/1666/5401/products/IMG-7040_1024x.JPG?v=1504456880", active?:true, inventory: 0)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

#dunder items
ream = dunder.items.create(name: "Ream of Paper", description: "So much paper!", price: 8, image: "https://mercari-images.global.ssl.fastly.net/photos/m66267444043_1.jpg?1567729247", inventory: 174)
dundie = dunder.items.create(name: "Dundie Award", description: "Everyone wants one!", price: 16, image: "https://images-na.ssl-images-amazon.com/images/I/712t-j2WvwL._UX679_.jpg", inventory: 12)

#tire_reviews
review_1 = tire.reviews.create(title: 'Title 1', content: "This is content for review 1", rating: 1)
review_2 = tire.reviews.create(title: 'Title 2', content: "This is content for review 2", rating: 2)
review_3 = tire.reviews.create(title: 'Title 3', content: "This is content for review 3", rating: 3)
review_4 = tire.reviews.create(title: 'Title 4', content: "This is content for review 4", rating: 1)
review_5 = tire.reviews.create(title: 'Title 5', content: "This is content for review 5", rating: 2)
review_6 = tire.reviews.create(title: 'Title 6', content: "This is content for review 6", rating: 3)

#bike_reviews
review_7 = bike.reviews.create(title: 'Title 1', content: "This is content for review 1", rating: 1)
review_8 = bike.reviews.create(title: 'Title 2', content: "This is content for review 2", rating: 4)
review_9 = bike.reviews.create(title: 'Title 3', content: "This is content for review 3", rating: 5)
review_10 = bike.reviews.create(title: 'Title 4', content: "This is content for review 4", rating: 1)
review_11 = bike.reviews.create(title: 'Title 5', content: "This is content for review 5", rating: 1)
review_12 = bike.reviews.create(title: 'Title 6', content: "This is content for review 6", rating: 1)

#pull_toy_reviews
review_13 = pull_toy.reviews.create(title: 'Title 1', content: "This is content for review 1", rating: 5)
review_14 = pull_toy.reviews.create(title: 'Title 2', content: "This is content for review 2", rating: 2)
review_15 = pull_toy.reviews.create(title: 'Title 3', content: "This is content for review 3", rating: 5)
review_16 = pull_toy.reviews.create(title: 'Title 4', content: "This is content for review 4", rating: 4)
review_17 = pull_toy.reviews.create(title: 'Title 5', content: "This is content for review 5", rating: 5)
review_18 = pull_toy.reviews.create(title: 'Title 6', content: "This is content for review 6", rating: 5)

#bone_reviews
review_19 = dog_bone.reviews.create(title: 'Title 1', content: "This is content for review 1", rating: 5)
review_20 = dog_bone.reviews.create(title: 'Title 2', content: "This is content for review 2", rating: 4)
review_21 = dog_bone.reviews.create(title: 'Title 3', content: "This is content for review 3", rating: 1)
review_22 = dog_bone.reviews.create(title: 'Title 4', content: "This is content for review 4", rating: 3)
review_23 = dog_bone.reviews.create(title: 'Title 5', content: "This is content for review 5", rating: 5)
review_24 = dog_bone.reviews.create(title: 'Title 6', content: "This is content for review 6", rating: 5)

#ream_reviews
review_25 = ream.reviews.create(title: 'Title 1', content: "This is content for review 1", rating: 3)
review_26 = ream.reviews.create(title: 'Title 2', content: "This is content for review 2", rating: 3)
review_27 = ream.reviews.create(title: 'Title 3', content: "This is content for review 3", rating: 3)
review_28 = ream.reviews.create(title: 'Title 4', content: "This is content for review 4", rating: 2)
review_29 = ream.reviews.create(title: 'Title 5', content: "This is content for review 5", rating: 2)
review_30 = ream.reviews.create(title: 'Title 6', content: "This is content for review 6", rating: 2)

#dundie_reviews
review_31 = dundie.reviews.create(title: 'Title 1', content: "This is content for review 1", rating: 3)
review_32 = dundie.reviews.create(title: 'Title 2', content: "This is content for review 2", rating: 3)
review_33 = dundie.reviews.create(title: 'Title 3', content: "This is content for review 3", rating: 4)
review_34 = dundie.reviews.create(title: 'Title 4', content: "This is content for review 4", rating: 5)
review_35 = dundie.reviews.create(title: 'Title 5', content: "This is content for review 5", rating: 6)

#users
regular_user_1 = User.create!(name: "Jane Testing",
              email: "regular_user_1@emal.com",
              password: "123")
address_1 = Address.create(address_type: "primary",
              name: "Jane Testing",
              address: "123 North St",
              city: "Denver",
              state: "CO",
              zipcode: "77652",
              user: regular_user_1)
regular_user_2 = User.create!(name: "John Testing",
              email: "regular_user_2@email.com",
              password: "123")
address_2 = Address.create(address_type: "primary",
              name: "John Testing",
              address: "123 Happy Street",
              city: "Testing City",
              state: "CO",
              zipcode: "77652",
              user: regular_user_2)
merchant_employee = User.create!(name: "Merchant Employee",
              email: "merchant_employee@email.com",
              password: "123",
              role: 1,
              merchant: dunder)
address_3 = Address.create(name: "Michael Scott",
              address_type: "primary",
              address: "1725 Slough Ave",
              city: "Scranton",
              state: "PA",
              zipcode: "18501",
              user: merchant_employee)
merchant_admin = User.create!(name: "Merchant Admin",
              email: "merchant_admin@email.com",
              password: "123",
              role: 2,
              merchant: dunder)
address_4 = Address.create(name: "Michael Scott",
              address_type: "primary",
              address: "1725 Slough Ave",
              city: "Scranton",
              state: "PA",
              zipcode: "18501",
              user: merchant_admin)
admin_user = User.create!(name: "Admin",
              email: "admin@email.com",
              password: "123",
              role: 3)
address_5 = Address.create(name: "Admin",
              address_type: "primary",
              address: "123 Address",
              city: "City",
              state: "ST",
              zipcode: "12222",
              user: admin_user)

order_1 = Order.create!(status: "pending", address: address_1)
  item_order_1 = ItemOrder.create!(order: order_1, item: tire, quantity: 2, price: tire.price, user: regular_user_1, fulfilled?: 0)
  item_order_2 = ItemOrder.create!(order: order_1, item: bike, quantity: 5, price: bike.price, user: regular_user_1, fulfilled?: 0)
  item_order_3 = ItemOrder.create!(order: order_1, item: watch, quantity: 5, price: watch.price, user: regular_user_1, fulfilled?: 0)

order_2 = Order.create!(status: "shipped", address: address_2)
  item_order_4 = ItemOrder.create(order: order_2, item: bike, quantity: 12, price: bike.price, user: regular_user_2)
  item_order_5 = ItemOrder.create(order: order_2, item: dog_bone, quantity: 3, price: dog_bone.price, user: regular_user_2)

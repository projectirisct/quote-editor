# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create companies from fixtures data
companies = {
  'kpmg' => Company.find_or_create_by!(name: 'KPMG'),
  'pwc' => Company.find_or_create_by!(name: 'PwC')
}

# Create users from fixtures data
users_data = [
  {
    email: 'accountant@kpmg.com',
    password: 'password',
    company: companies['kpmg']
  },
  {
    email: 'manager@kpmg.com',
    password: 'password',
    company: companies['kpmg']
  },
  {
    email: 'eavesdropper@pwc.com',
    password: 'password',
    company: companies['pwc']
  }
]

users_data.each do |user_data|
  user = User.find_or_initialize_by(email: user_data[:email])
  user.password = user_data[:password]
  user.password_confirmation = user_data[:password]
  user.company = user_data[:company]
  user.save!
end

puts "Created or found #{companies.length} companies and #{users_data.length} users from fixtures data"

# Create quotes from fixtures data
quotes_data = [
  { name: 'First quote', company: companies['kpmg'] },
  { name: 'Second quote', company: companies['kpmg'] },
  { name: 'Third quote', company: companies['kpmg'] },
  { name: 'Fourth quote', company: companies['pwc'] }
]

quotes_data.each do |quote_data|
  Quote.find_or_create_by!(name: quote_data[:name], company: quote_data[:company])
end

puts "Created or found #{quotes_data.length} quotes from fixtures data"

# Create line item dates from fixtures data
first_quote = Quote.find_by(name: 'First quote')

line_item_dates_data = [
  { quote: first_quote, date: Date.current },
  { quote: first_quote, date: Date.current + 1.week }
]

line_item_dates_data.each do |item|
  LineItemDate.find_or_create_by!(quote: item[:quote], date: item[:date])
end

puts "Created or found #{line_item_dates_data.length} line item dates from fixtures data"

# Create line items from fixtures data
line_item_dates = {
  'today' => LineItemDate.find_by(date: Date.current),
  'next_week' => LineItemDate.find_by(date: Date.current + 1.week)
}

line_items_data = [
  { line_item_date: line_item_dates['today'], name: 'Meeting room', description: 'A cosy meeting room for 10 people', quantity: 1, unit_price: 1000 },
  { line_item_date: line_item_dates['today'], name: 'Meal tray', description: 'Our delicious meal tray', quantity: 10, unit_price: 25 },
  { line_item_date: line_item_dates['next_week'], name: 'Meeting room', description: 'A cosy meeting room for 10 people', quantity: 1, unit_price: 1000 },
  { line_item_date: line_item_dates['next_week'], name: 'Meal tray', description: 'Our delicious meal tray', quantity: 10, unit_price: 25 }
]

line_items_data.each do |item|
  LineItem.find_or_create_by!(
    line_item_date: item[:line_item_date],
    name: item[:name],
    description: item[:description],
    quantity: item[:quantity],
    unit_price: item[:unit_price]
  )
end

puts "Created or found #{line_items_data.length} line items from fixtures data"

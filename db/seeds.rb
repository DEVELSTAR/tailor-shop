# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Business Info
BusinessInfo.find_or_create_by(name: "Vinayaka Tailors") do |info|
  info.address = "2nd Cross Rd, Vinayaka Nagar, Muneswara Nagar, Sector 6, HSR Layout, Bengaluru, Karnataka 560068"
  info.hours = "Mon–Sat 10 am–8:30 pm, Sun 10 am–8:30 pm"
  info.phone = "+91 9876543210" # Placeholder
  info.description = "Expert ladies tailor specializing in custom stitching, alterations, and modern designs. We ensure the perfect fit for every occasion."
end

# Reviews
reviews = [
  { rating: 5, reviewer_name: "Nikita Pandey", comment: "Great experience! My dresses fit beautifully after alteration. Will definitely come back." },
  { rating: 4, reviewer_name: "Sindhu R", comment: "Perfect stitching at very good price" },
  { rating: 5, reviewer_name: "Sunil Joshi", comment: "Very good stitching finishing and designs also." }
]

reviews.each do |review_data|
  Review.find_or_create_by(reviewer_name: review_data[:reviewer_name]) do |review|
    review.rating = review_data[:rating]
    review.comment = review_data[:comment]
    review.approved = true
  end
end

# Admin User
User.find_or_create_by(email_address: "admin@example.com") do |user|
  user.password = "password123"
end

# Clear existing categories to avoid duplicates when reseeding with new structure
Category.destroy_all
Product.destroy_all

# Categories
saree_cat = Category.create!(name: "Saree Services", description: "Fall, Pico, Tassels & Pre-pleating")
bottom_cat = Category.create!(name: "Bottom Wear", description: "Chudidar, Salwar, Palazzo, Pants & More")
embroidery_cat = Category.create!(name: "Embroidery", description: "Hand & Machine Work")
addons_cat = Category.create!(name: "Add-ons", description: "Linings, Zips, Pads & Finishing")
blouse_cat = Category.create!(name: "Blouse Stitching", description: "Dart, Princess Cut, Katori & Designer")
lehenga_cat = Category.create!(name: "Anarkali & Lehenga", description: "Custom stitching for occasions")
mens_cat = Category.create!(name: "Men's Tailoring", description: "Formals & Traditional Wear")
top_cat = Category.create!(name: "Tops & Kurtis", description: "Kurtis, Shirts & Slips")
skirt_cat = Category.create!(name: "Skirts & Frocks", description: "Gowns, Skirts & Jumpsuits")
express_cat = Category.create!(name: "Express Tailoring", description: "Quick Service Charges")
design_cat = Category.create!(name: "Designing Consultation", description: "Expert advice charges")
delivery_cat = Category.create!(name: "Delivery", description: "Delivery Charges")
measurement_cat = Category.create!(name: "Measurement Service", description: "Measurement Charges")


# Saree Products
Product.create!(name: "Fall & Pico (Machine + Hand Hemming)", price: 250, category: saree_cat)
Product.create!(name: "Fall & Pico (Two side Hand Hemming)", price: 300, category: saree_cat)
Product.create!(name: "Heavy Work Saree Fall & Pico", price: 400, description: "Two side Hand Hemming", category: saree_cat)
Product.create!(name: "Ready To Wear Saree", price: 1500, description: "Starting from Rs.1500 to Rs.2300", category: saree_cat)
Product.create!(name: "Saree Self Tassels", price: 350, description: "Starting Price", category: saree_cat)
Product.create!(name: "Saree Baby Tassels", price: 750, description: "Starting Price", category: saree_cat)
Product.create!(name: "Pre-pleated Saree", price: 500, category: saree_cat)

# Bottom Wear Products
Product.create!(name: "Chudidar (Without Lining)", price: 590, category: bottom_cat)
Product.create!(name: "Chudidar (With Lining)", price: 790, category: bottom_cat)
Product.create!(name: "Salwar (Without Lining)", price: 590, category: bottom_cat)
Product.create!(name: "Salwar (With Lining)", price: 790, category: bottom_cat)
Product.create!(name: "Palazzo (Without Lining)", price: 650, category: bottom_cat)
Product.create!(name: "Palazzo (With Lining)", price: 850, category: bottom_cat)
Product.create!(name: "Patiala/Afghani Pant (Without Lining)", price: 690, category: bottom_cat)
Product.create!(name: "Patiala/Afghani Pant (With Lining)", price: 1000, category: bottom_cat)
Product.create!(name: "Straight Pant (Without Lining)", price: 750, category: bottom_cat)
Product.create!(name: "Straight Pant (With Lining)", price: 950, category: bottom_cat)
Product.create!(name: "Tulip Pant (Without Lining)", price: 1500, category: bottom_cat)
Product.create!(name: "Kite Pant (Without Lining)", price: 1700, category: bottom_cat)
Product.create!(name: "Sharara (Without Lining)", price: 1500, category: bottom_cat)
Product.create!(name: "Sharara (With Lining)", price: 2250, category: bottom_cat)
Product.create!(name: "Shorts", price: 1500, category: bottom_cat)

# Embroidery
Product.create!(name: "Hand Embroidery", price: 3000, description: "Starting Price", category: embroidery_cat)
Product.create!(name: "Machine Embroidery", price: 2000, description: "Starting Price", category: embroidery_cat)

# Measurement
Product.create!(name: "Measurement Charges", price: 50, category: measurement_cat)

# Add-ons
Product.create!(name: "Piping", price: 250, description: "Starting Price", category: addons_cat)
Product.create!(name: "Dori", price: 100, description: "Starting Price", category: addons_cat)
Product.create!(name: "Elastic", price: 150, category: addons_cat)
Product.create!(name: "Pair of Pockets", price: 100, category: addons_cat)
Product.create!(name: "Dori with Tassel", price: 200, description: "Starting Price", category: addons_cat)
Product.create!(name: "Zip", price: 200, category: addons_cat)
Product.create!(name: "Pads (D/Triangle/I/Soft)", price: 150, description: "Addition to padded price", category: addons_cat)
Product.create!(name: "Fabric Fusing", price: 650, description: "Starting Price", category: addons_cat)
Product.create!(name: "Premium Finishing - Blouse", price: 300, category: addons_cat)
Product.create!(name: "Premium Finishing - Kurta", price: 550, description: "Hemming in Neck, Sleeves, Slit, Flair", category: addons_cat)
Product.create!(name: "Custom Add-ons", price: 0, description: "Patch Work, Collar, Cuff, Borders, Buttons, Lace - As per requirement", category: addons_cat)
Product.create!(name: "Crepe Lining", price: 150, description: "Additional Rs.150 - Rs.200", category: addons_cat)

# Blouse
Product.create!(name: "Dart Blouse (Without Lining)", price: 870, category: blouse_cat)
Product.create!(name: "Dart Blouse (With Lining)", price: 1070, category: blouse_cat)
Product.create!(name: "Dart Blouse (Padded)", price: 1500, category: blouse_cat)
Product.create!(name: "Princess Cut (Without Lining)", price: 1040, category: blouse_cat)
Product.create!(name: "Princess Cut (With Lining)", price: 1350, category: blouse_cat)
Product.create!(name: "Princess Cut (Padded)", price: 1650, category: blouse_cat)
Product.create!(name: "Double Katori Cut (Without Lining)", price: 1250, category: blouse_cat)
Product.create!(name: "Double Katori Cut (With Lining)", price: 1550, category: blouse_cat)
Product.create!(name: "Double Katori Cut (Padded)", price: 1750, category: blouse_cat)
Product.create!(name: "Elasticated Princess Cut (Padded)", price: 2600, category: blouse_cat)
Product.create!(name: "Blouse with Fabric Fusing", price: 500, description: "Addition to base price", category: blouse_cat)
Product.create!(name: "Designer Blouse", price: 3000, description: "Starting Price", category: blouse_cat)

# Anarkali & Lehenga
Product.create!(name: "Anarkali (Without Lining)", price: 2500, category: lehenga_cat)
Product.create!(name: "Anarkali (With Lining)", price: 3950, category: lehenga_cat)
Product.create!(name: "Anarkali (Padded)", price: 4350, category: lehenga_cat)
Product.create!(name: "Lehenga", price: 3500, category: lehenga_cat)
Product.create!(name: "Langa Blouse (Kids 1yr+)", price: 2500, description: "Range: Rs.2500 - Rs.3850", category: lehenga_cat)

# Men's Tailoring
Product.create!(name: "Formal Shirt", price: 1000, category: mens_cat)
Product.create!(name: "Formal Pant", price: 1200, category: mens_cat)
Product.create!(name: "Blazer", price: 3960, category: mens_cat)
Product.create!(name: "2 Piece Suit", price: 4860, category: mens_cat)
Product.create!(name: "3 Piece Suit", price: 5660, category: mens_cat)
Product.create!(name: "Kurta", price: 950, category: mens_cat)
Product.create!(name: "Pyjama", price: 640, category: mens_cat)
Product.create!(name: "Pathani", price: 950, category: mens_cat)
Product.create!(name: "Nehru Jacket", price: 2960, category: mens_cat)

# Delivery
Product.create!(name: "Standard Delivery", price: 80, description: "For orders below Rs.1000", category: delivery_cat)
Product.create!(name: "Same Day Delivery", price: 300, description: "Range: Rs.300 - Rs.500", category: delivery_cat)

# Tops
Product.create!(name: "Kurti (Without Lining)", price: 790, category: top_cat)
Product.create!(name: "Kurti (With Body Lining)", price: 990, category: top_cat)
Product.create!(name: "Kurti (Sleeve + Body Lining)", price: 1090, category: top_cat)
Product.create!(name: "Shirt Top (Without Lining)", price: 1400, category: top_cat)
Product.create!(name: "Shirt Top (With Lining)", price: 1780, category: top_cat)
Product.create!(name: "Slip with Fabric", price: 1040, category: top_cat)

# Skirt & Frock
Product.create!(name: "Cancan Skirt", price: 800, description: "Rs.800 - Rs.2000", category: skirt_cat)
Product.create!(name: "Skirt (Without Lining)", price: 1300, category: skirt_cat)
Product.create!(name: "Skirt (With Lining)", price: 1700, category: skirt_cat)
Product.create!(name: "Frock/Dress (Without Lining)", price: 1600, category: skirt_cat)
Product.create!(name: "Frock/Dress (With Lining)", price: 2000, category: skirt_cat)
Product.create!(name: "Full-Length Gown", price: 3800, description: "Starting Price", category: skirt_cat)
Product.create!(name: "Saree Skirt/Petticoat (Crepe)", price: 850, category: skirt_cat)
Product.create!(name: "Shapewear Saree Skirt", price: 900, category: skirt_cat)
Product.create!(name: "Jumpsuit (Without Lining)", price: 2000, description: "Starting Price", category: skirt_cat)
Product.create!(name: "Kaftan (Without Lining)", price: 1500, description: "Starting Price", category: skirt_cat)

# Express Tailoring
Product.create!(name: "Express - Stitching Item", price: 200, description: "Per Piece", category: express_cat)
Product.create!(name: "Express - Saree", price: 100, description: "Per Piece", category: express_cat)
Product.create!(name: "Express - Embroidery", price: 250, description: "Per Piece", category: express_cat)

# Design Charge
Product.create!(name: "Consultation (First 20 mins)", price: 100, category: design_cat)
Product.create!(name: "Consultation (Addl 10 mins)", price: 50, category: design_cat)

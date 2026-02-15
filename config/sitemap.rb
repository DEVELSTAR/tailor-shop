# Set the host name for URL generation
SitemapGenerator::Sitemap.default_host = "https://fashionparadise.example.com" # Replace with actual domain

SitemapGenerator::Sitemap.create do
  # Add root path
  add root_path, priority: 1.0, changefreq: 'daily'
  
  # Add static pages
  add galleries_path, priority: 0.8, changefreq: 'weekly'
  add new_booking_path, priority: 0.7, changefreq: 'weekly'
  add new_review_path, priority: 0.6, changefreq: 'weekly'
  
  # Add categories (for SEO)
  Category.includes(:products).ordered.each do |category|
    add category_path(category), priority: 0.6, changefreq: 'weekly', lastmod: category.updated_at
  end
  
  # Add products (for SEO)
  Product.includes(:category).recent.limit(50).each do |product|
    add product_path(product), priority: 0.5, changefreq: 'weekly', lastmod: product.updated_at
  end
end

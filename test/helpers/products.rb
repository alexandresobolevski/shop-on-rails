module ProductTestHelpers
  def new_product_from_args(**args)
    Product.new(
      title: args.dig(:title) || 'Blue pants',
      description: args.dig(:description) || 'yyy',
      image_url: args.dig(:image_url) || 'zzz.jpg',
      price: args.dig(:price) || 1.00,
    )
  end
end

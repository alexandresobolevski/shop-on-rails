require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test 'empty product fails validation' do
    product = Product.new
    assert(product.invalid?)
    assert(product.errors[:title].any?)
    assert(product.errors[:description].any?)
    assert(product.errors[:price].any?)
    assert(product.errors[:image_url].any?)
  end

  test 'product price must be positive' do
    product = Product.new(
      title: 'Blue pants',
      description: 'yyy',
      image_url: 'zzz.jpg',
    )
    product.price = -0.01
    assert(product.invalid?)
    assert_equal(['must be greater than or equal to 0.01'], product.errors[:price])
    product.price = 0
    assert(product.invalid?)
    assert_equal(['must be greater than or equal to 0.01'], product.errors[:price])
    product.price = 0.01
    assert(product.valid?)
  end

  test 'image url accepts a limited list of formats' do
    ok = ['jpg', 'png', 'gif'].map { |ext| "file.#{ext}" }
    bad = ['file.doc', 'file.jpg/more', 'file.jpg.doc']
    ok.each do |image|
      assert(new_product_from_args(image_url: image).valid?)
    end
    bad.each do |image|
      assert(new_product_from_args(image_url: image).invalid?)
    end
  end

  test 'title has to be unique' do
    product = new_product_from_args(title: products(:one).title)
    assert(product.invalid?)
    assert_equal(
      [I18n.translate('errors.messages.taken')],
      product.errors[:title],
    )
  end
end

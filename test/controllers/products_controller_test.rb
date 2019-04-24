require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_old = products(:one)
    @product_new = new_product_from_args(title: 'drowsier glamor')
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: {
        product: {
          description: @product_new.description,
          image_url: @product_new.image_url,
          price: @product_new.price,
          title: @product_new.title
        }
      }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product_old)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product_old)
    assert_response :success
  end

  test "can't delete product in cart" do
    assert_difference('Product.count', 0) do
      delete product_url(products(:two))
    end

    assert_redirected_to products_url
  end

  test "should update product" do
    patch product_url(@product_old), params: {
      product: {
        description: @product_old.description,
        image_url: @product_old.image_url,
        price: @product_old.price,
        title: 'New Title'
      }
    }
    assert_response :success
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product_old)
    end

    assert_redirected_to products_url
  end
end

require 'test_helper'

class HamburguesaIngredientesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hamburguesa_ingrediente = hamburguesa_ingredientes(:one)
  end

  test "should get index" do
    get hamburguesa_ingredientes_url, as: :json
    assert_response :success
  end

  test "should create hamburguesa_ingrediente" do
    assert_difference('HamburguesaIngrediente.count') do
      post hamburguesa_ingredientes_url, params: { hamburguesa_ingrediente: { hid: @hamburguesa_ingrediente.hid, iid: @hamburguesa_ingrediente.iid } }, as: :json
    end

    assert_response 201
  end

  test "should show hamburguesa_ingrediente" do
    get hamburguesa_ingrediente_url(@hamburguesa_ingrediente), as: :json
    assert_response :success
  end

  test "should update hamburguesa_ingrediente" do
    patch hamburguesa_ingrediente_url(@hamburguesa_ingrediente), params: { hamburguesa_ingrediente: { hid: @hamburguesa_ingrediente.hid, iid: @hamburguesa_ingrediente.iid } }, as: :json
    assert_response 200
  end

  test "should destroy hamburguesa_ingrediente" do
    assert_difference('HamburguesaIngrediente.count', -1) do
      delete hamburguesa_ingrediente_url(@hamburguesa_ingrediente), as: :json
    end

    assert_response 204
  end
end

require 'test_helper'

class ApexftdataControllerTest < ActionDispatch::IntegrationTest
  setup do
    @apexftdatum = apexftdata(:one)
  end

  test "should get index" do
    get apexftdata_url
    assert_response :success
  end

  test "should get new" do
    get new_apexftdatum_url
    assert_response :success
  end

  test "should create apexftdatum" do
    assert_difference('Apexftdatum.count') do
      post apexftdata_url, params: { apexftdatum: { interest: @apexftdatum.interest, stockprice: @apexftdatum.stockprice, strikeprice: @apexftdatum.strikeprice, timetomaturity: @apexftdatum.timetomaturity, volatility: @apexftdatum.volatility } }
    end

    assert_redirected_to apexftdatum_url(Apexftdatum.last)
  end

  test "should show apexftdatum" do
    get apexftdatum_url(@apexftdatum)
    assert_response :success
  end

  test "should get edit" do
    get edit_apexftdatum_url(@apexftdatum)
    assert_response :success
  end

  test "should update apexftdatum" do
    patch apexftdatum_url(@apexftdatum), params: { apexftdatum: { interest: @apexftdatum.interest, stockprice: @apexftdatum.stockprice, strikeprice: @apexftdatum.strikeprice, timetomaturity: @apexftdatum.timetomaturity, volatility: @apexftdatum.volatility } }
    assert_redirected_to apexftdatum_url(@apexftdatum)
  end

  test "should destroy apexftdatum" do
    assert_difference('Apexftdatum.count', -1) do
      delete apexftdatum_url(@apexftdatum)
    end

    assert_redirected_to apexftdata_url
  end
end

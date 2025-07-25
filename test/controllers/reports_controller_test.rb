require "test_helper"

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get top_books" do
    get reports_top_books_url
    assert_response :success
  end

  test "should get yearly_stats" do
    get reports_yearly_stats_url
    assert_response :success
  end
end

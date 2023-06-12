require 'rails_helper'

RSpec.describe "cards/new", type: :view do
  before(:each) do
    assign(:card, Card.new(
      customer: nil,
      company: nil,
      name: "MyString",
      score: 1,
      status: 1
    ))
  end

  it "renders new card form" do
    render

    assert_select "form[action=?][method=?]", cards_path, "post" do

      assert_select "input[name=?]", "card[customer_id]"

      assert_select "input[name=?]", "card[company_id]"

      assert_select "input[name=?]", "card[name]"

      assert_select "input[name=?]", "card[score]"

      assert_select "input[name=?]", "card[status]"
    end
  end
end

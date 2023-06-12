require 'rails_helper'

RSpec.describe "cards/edit", type: :view do
  before(:each) do
    @card = assign(:card, Card.create!(
      customer: nil,
      company: nil,
      name: "MyString",
      score: 1,
      status: 1
    ))
  end

  it "renders the edit card form" do
    render

    assert_select "form[action=?][method=?]", card_path(@card), "post" do

      assert_select "input[name=?]", "card[customer_id]"

      assert_select "input[name=?]", "card[company_id]"

      assert_select "input[name=?]", "card[name]"

      assert_select "input[name=?]", "card[score]"

      assert_select "input[name=?]", "card[status]"
    end
  end
end

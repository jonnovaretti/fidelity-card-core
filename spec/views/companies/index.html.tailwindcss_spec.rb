require 'rails_helper'

RSpec.describe "companies/index", type: :view do
  before(:each) do
    assign(:companies, [
      Company.create!(
        name: "Name",
        user: nil,
        description: "Description",
        phone: "Phone"
      ),
      Company.create!(
        name: "Name",
        user: nil,
        description: "Description",
        phone: "Phone"
      )
    ])
  end

  it "renders a list of companies" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Description".to_s, count: 2
    assert_select "tr>td", text: "Phone".to_s, count: 2
  end
end

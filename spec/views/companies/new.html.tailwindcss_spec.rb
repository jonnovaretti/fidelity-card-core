require 'rails_helper'

RSpec.describe "companies/new", type: :view do
  before(:each) do
    assign(:company, Company.new(
      name: "MyString",
      user: nil,
      description: "MyString",
      phone: "MyString"
    ))
  end

  it "renders new company form" do
    render

    assert_select "form[action=?][method=?]", companies_path, "post" do

      assert_select "input[name=?]", "company[name]"

      assert_select "input[name=?]", "company[user_id]"

      assert_select "input[name=?]", "company[description]"

      assert_select "input[name=?]", "company[phone]"
    end
  end
end

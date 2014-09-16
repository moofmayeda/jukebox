require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

describe "creating a song" do
  it "is successful if an admin is signed in" do
    admin = FactoryGirl.create(:admin)
    login_as(admin, :scope => :user)
    visit songs_path
    click_link 'Add a song'
    fill_in 'Title', with: 'One More Hour'
    fill_in 'Artist', with: 'Sleater Kinney'
    click_button 'Create Song'
    expect(page).to have_content('One More Hour')
  end

  it "fails if a non-admin user is signed in" do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit songs_path
    expect(page).to have_no_content('Add a song')
  end
end

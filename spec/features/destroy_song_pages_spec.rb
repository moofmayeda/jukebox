require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

describe "deleting a song" do
  it "is successful if an admin is signed in" do
    admin = FactoryGirl.create(:admin)
    login_as(admin, :scope => :user)
    song = FactoryGirl.create(:song)
    visit song_path(song)
    click_link 'Remove song'
    expect(page).to have_no_content('One More Hour')
  end

  it "fails if a non-admin user is signed in" do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    song = FactoryGirl.create(:song)
    visit song_path(song)
    expect(page).to have_no_content('Remove song')
  end
end

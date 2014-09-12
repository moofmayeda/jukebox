require 'rails_helper'
require "cancan/matchers"

include Warden::Test::Helpers
Warden.test_mode!

describe User do
  describe "abilities" do
    it "lets a logged in admin add a song" do
      admin = FactoryGirl.create(:admin)
      login_as(admin, :scope => :user)
      ability = Ability.new(admin)
      expect(ability).to be_able_to(:create, Song)
    end

    it "prevents a logged in non-admin user from adding a song" do
      user = FactoryGirl.create(:user)
      login_as(user, :scope => :user)
      ability = Ability.new(user)
      expect(ability).to_not be_able_to(:create, Song)
    end
  end
end

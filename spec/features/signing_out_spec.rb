require "rails_helper"
        RSpec.feature "Signed-in users can sign out" do
          let!(:user) { FactoryGirl.create(:user) }
          before do
            login_as user
			end
          scenario do
            visit "/"
          	expect(page).to have_content "Signed in as"
            click_link "Sign Out"
            expect(page).to have_content "Signed out successfully."
end end
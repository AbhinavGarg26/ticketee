require "rails_helper"

RSpec.feature "User can create tickets" do
	before do
		visit "/"
		project = FactoryGirl.create(:project, name: "Internet Explorer")

		visit project_path(project)
		click_link "New Ticket"
	end

	scenario "with valid attributes" do
		fill_in "Name", with: "Non-standerds compliance!"
		fill_in "Description", with: "My pages are ugly!"

		click_button "Create Ticket"
		expect(page).to have_content "Ticket has been created."
	end

	scenario "with an invalid attributes" do
		click_button "Create Ticket"
		expect(page).to have_content "Ticket has not been created."
		expect(page).to have_content "Name can't be blank"
		expect(page).to have_content "Description can't be blank"
	end

	scenario "with an invalid Description" do
		fill_in "Name", with: "Non-standerds compliance!"
		fill_in "Description", with: "My pages"

		click_button "Create Ticket"
		expect(page).to have_content "Ticket has not been created."
		expect(page).to have_content "Description is too short"
	end
end

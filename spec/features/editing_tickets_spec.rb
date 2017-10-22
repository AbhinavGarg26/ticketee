require "rails_helper"
RSpec.feature "Users can edit existing tickets" do
  let(:project) { FactoryGirl.create(:project) }
  let(:user) { FactoryGirl.create(:user) }
    let(:stateopen) { FactoryGirl.create(:state, name: "Open", color: "Brown") }
    let(:ticket) { FactoryGirl.create(:ticket, project: project, author: user) }
  before do
    login_as(user)
    assign_role!(user, :editor, project)
    visit project_ticket_path(project, ticket)
    click_link "Edit Ticket"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Make it really shiny!"
    click_button "Update Ticket"
    expect(page).to have_content "Ticket has been updated."
    within("#ticket h2") do
      expect(page).to have_content "Make it really shiny!"
      expect(page).not_to have_content ticket.name
    end
  end
  scenario "with invalid attributes" do
    fill_in "Name", with: ""
    click_button "Update Ticket"
    expect(page).to have_content "Ticket has not been updated."
  end
end

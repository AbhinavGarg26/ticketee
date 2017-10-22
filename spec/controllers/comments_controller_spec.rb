require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { Project.create!(name: "Ticketee") }
  let(:state) { State.create!(name: "Hacked") }

  let(:ticket) { FactoryGirl.create(:ticket, project: project, author: user) }

  context "a user without permission to set state" do
    before :each do
      assign_role!(user, :editor, project)
      sign_in user
    end
    it "cannot transition a state by passing through state_id" do
      post :create, params: { comment: { text: "Did I hack it??",
                                 state_id: state.id },
                      ticket_id: ticket.id}
      ticket.reload
      #expect(ticket.state.name).not_to have_content "Hacked"
      expect(ticket.state).to be_nil
    end
  end
end

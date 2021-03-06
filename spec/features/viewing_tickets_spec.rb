require "rails_helper"
RSpec.feature "Users can view tickets" do
          let(:user) { FactoryGirl.create(:user) }
    let(:stateopen) { FactoryGirl.create(:state, name: "Open", color: "Brown") }
          before do
            sublime = FactoryGirl.create(:project, name: "Sublime Text 3")
            assign_role!(user, :viewer, sublime)
            FactoryGirl.create(:ticket, project_id: sublime.id, author: user,
             name: "Make it shiny!",
             description: "Gradients! Starbursts! Oh my!", state: stateopen)

            ie = FactoryGirl.create(:project, name: "Internet Explorer")
            assign_role!(user, :viewer, ie)
            FactoryGirl.create(:ticket, project_id: ie.id, author: user,
              name: "Standards compliance", description: "Isn't a joke.", state: stateopen)
            
            login_as(user)
            visit "/" 
          end
          scenario "for a given project" do
            click_link "Sublime Text 3"
            expect(page).to have_content "Make it shiny!"
            expect(page).to_not have_content "Standards compliance"

            click_link "Make it shiny!"
            within("#ticket h2") do
              expect(page).to have_content "Make it shiny!"
            end
            expect(page).to have_content "Gradients! Starbursts! Oh my!"
          end
end
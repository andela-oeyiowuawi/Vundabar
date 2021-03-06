require "spec_helper"

RSpec.describe "Todo Spec", type: :feature do
  after(:each) do
    Todo.destroy_all
  end

  scenario "when a user visits the landing page" do
    visit "/"

    expect(page).to have_content "Create New Todo"
    expect(page).to have_content "Pending Todos"
    expect(page).to have_content "Completed Todos"
  end

  scenario "when a user creates a new todo item" do
    visit "/"
    click_link "Create New Todo"
    fill_in "title", with: "Andela"
    fill_in "body", with: "The top one percent Company"
    select "Pending", from: "status"
    click_button "Create New Task"

    expect(page).to have_content "Andela"
    expect(page).to have_content "The top one percent Company"
    expect(page).to have_content "pending"
    expect(page).to have_content "Delete"
    expect(page).to have_content "Edit"
  end

  scenario "when deleting a todo" do
    create_list(:todo, 2)
    create(:todo, title: "Test")

    visit "/"
    page.all(".delete")[-1].click

    within("div#pending-todo") do
      expect(page).to have_css("li", count: 2)
    end
    expect(page).to have_no_content("Test")
  end

  scenario "when updating an existing to" do
    todo = Todo.create(attributes_for(:todo))
    title = "Another title"
    body = "Testing update"

    visit "/todolist/#{todo.id}/edit"
    fill_in "title", with: title
    fill_in "body", with: body
    select "Done", from: "status"
    click_button "update_task"

    expect(page.current_path).to eq "/todolist/#{todo.id}"
    expect(page).to have_content "Status: done"
    expect(page).to have_content body
    expect(page).to have_content title
  end
end

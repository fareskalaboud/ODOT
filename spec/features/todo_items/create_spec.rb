require 'spec_helper'

describe "Creating todo items" do 
	
	let!(:todo_list) { TodoList.create(title: "Groceries", description: "List of food to buy.")}

	def visitToDoList(list)
		visit "/todo_lists"

		within ("#todo_list_#{todo_list.id}") do
			click_link "List Items"
		end
	end

	it "is successful with valid content" do 
		visitToDoList(todo_list)
		click_link "New Todo Item"
		fill_in "Content", with: "Milk"
		click_button "Save"

		expect(page).to have_content("Added todo list item.")
		within "ul.todo_items" do 
			expect(page).to have_content("Milk")
		end
	end

	it "is displays an error on no content" do 
		visitToDoList(todo_list)
		click_link "New Todo Item"
		fill_in "Content", with: ""
		click_button "Save"

		within "div.flash" do 
			expect(page).to have_content("There was a problem adding this todo list item.")
		end
			
		expect(page).to have_content("Content can't be blank")
	end

	it "is displays an error on content being less than 2 characters" do 
		visitToDoList(todo_list)
		click_link "New Todo Item"
		fill_in "Content", with: "X"
		click_button "Save"

		within "div.flash" do 
			expect(page).to have_content("There was a problem adding this todo list item.")
		end

		expect(page).to have_content("Content is too short")
		
	end

end

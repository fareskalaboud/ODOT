require 'spec_helper'

describe "Editing todo items" do 
	
	let!(:todo_list) { TodoList.create(title: "Groceries", description: "List of food to buy.")}
	let!(:todo_item) { todo_list.todo_items.create(content: "Milk")}	

	it "is successful" do
		visitToDoList(todo_list)

		within "#todo_item_#{todo_item.id}" do 
			click_link "Delete"
		end

		expect(page).to have_content("Todo list item was deleted")

		expect(TodoItem.count).to eq(0)

	end
end

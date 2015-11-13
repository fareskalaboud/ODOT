require 'spec_helper'

describe "Editing todo items" do 
	
	let!(:todo_list) { TodoList.create(title: "Groceries", description: "List of food to buy.")}
	let!(:todo_item) { todo_list.todo_items.create(content: "Milk")}

	it "is successful when a todo list item is marked as completed" do
		expect(todo_item.completed_at).to be_nil
		visitToDoList(todo_list)

		within dom_id_for(todo_item) do
			click_link "Mark Complete"
		end

		todo_item.reload

		expect(todo_item.completed_at).to_not be_nil
	end
end
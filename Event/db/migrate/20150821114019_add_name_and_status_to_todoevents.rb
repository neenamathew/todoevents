class AddNameAndStatusToTodoevents < ActiveRecord::Migration
  def change
    add_column :todoevents, :name, :string
    add_column :todoevents, :status, :string
  end
end

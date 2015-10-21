class CreateTodoevents < ActiveRecord::Migration
  def change
    create_table :todoevents do |t|

      t.timestamps null: false
    end
  end
end

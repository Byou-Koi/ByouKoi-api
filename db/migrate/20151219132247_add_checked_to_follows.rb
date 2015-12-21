class AddCheckedToFollows < ActiveRecord::Migration
  def change
    add_column :follows, :checked, :boolean, :default => false
  end
end

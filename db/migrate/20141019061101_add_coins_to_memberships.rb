class AddCoinsToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :coins, :integer, default: 0
  end
end

class RemoveBirthYearFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :birth_year, :integer
  end
end

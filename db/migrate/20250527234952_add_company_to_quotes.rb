class AddCompanyToQuotes < ActiveRecord::Migration[7.2]
  def change
    add_reference :quotes, :company, null: false, foreign_key: true
  end
end

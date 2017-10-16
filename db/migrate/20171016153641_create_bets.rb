class CreateBets < ActiveRecord::Migration[5.1]
  def change
    create_table :bets do |t|
      t.string :date
      t.string :name
      t.string :odds
      t.string :margin

      t.timestamps
    end
  end
end

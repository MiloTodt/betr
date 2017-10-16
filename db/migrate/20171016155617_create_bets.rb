class CreateBets < ActiveRecord::Migration[5.1]
  def change
    create_table :bets do |t|
      t.string :date
      t.string :fighter
      t.string :odds
      t.string :margin

      t.timestamps
    end
  end
end

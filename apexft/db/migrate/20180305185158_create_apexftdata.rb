class CreateApexftdata < ActiveRecord::Migration[5.1]
  def change
    create_table :apexftdata do |t|
      t.decimal :stockprice
      t.decimal :strikeprice
      t.decimal :timetomaturity
      t.decimal :interest
      t.decimal :volatility

      t.timestamps
    end
  end
end

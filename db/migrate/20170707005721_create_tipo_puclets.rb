class CreateTipoPuclets < ActiveRecord::Migration[5.1]
  def change
    create_table :tipo_puclets do |t|
      t.string :nome

      t.timestamps
    end
  end
end

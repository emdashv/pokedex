class CreatePokemons < ActiveRecord::Migration
  def change
    create_table :pokemons do |t|
      t.string :name
      t.text :description
      t.string :abilities
      t.string :types
      t.string :weaknesses

      t.timestamps
    end
  end
end

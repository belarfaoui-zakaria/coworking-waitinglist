class CreateFreelancers < ActiveRecord::Migration[6.0]
  def change
    create_table :freelancers do |t|
      t.text :biography
      t.string :name
      t.string :phone_number
      t.string :email # unique or not ? not enough information in the specs
      t.timestamps
    end
  end
end

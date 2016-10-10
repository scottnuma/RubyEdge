class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.string :label
      t.date :date

      t.timestamps null: false
    end
  end
end

# Active Record Basics - http://guides.rubyonrails.org/active_record_basics.html
# To actually create the table, you'd run rails db:migrate and to roll it back, rails db:rollback.

# Rails on Rail MIgrations - http://www.tutorialspoint.com/ruby-on-rails/rails-migrations.htm
# Actually recommends `rake db:migrate`

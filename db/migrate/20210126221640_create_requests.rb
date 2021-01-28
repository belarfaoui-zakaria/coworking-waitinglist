# frozen_string_literal: true

class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.string :confirmation_token # generated tooken to validate request
      t.datetime :confirmed_at # date when freelancer confirmed his account
      # t.datetime :confirmation_sent_at # i think i will not use this one it will help for token expiration
      t.datetime :accepted_at # date when the request is accepted
      t.datetime :will_expire_at # will hold expected expiration date [3 months from now].change if freelancer reconfirm
      t.datetime :expired_at # request expiration date if not reconfirmed
      t.references :freelancer # reference to freelancer
      t.string :state # hold request's state [default: unconfirmed], confirmed, accepted, expired
      t.timestamps
    end

    add_index :requests, :confirmation_token, unique: true
  end
end

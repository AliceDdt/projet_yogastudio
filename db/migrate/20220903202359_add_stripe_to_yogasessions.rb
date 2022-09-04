class AddStripeToYogasessions < ActiveRecord::Migration[7.0]
  def change
    add_column :yoga_sessions, :stripe_yoga_session_id, :string
    add_column :yoga_sessions, :stripe_price_id, :string
  end
end

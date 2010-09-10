class User < ActiveRecord::Base
  include Clearance::User

  has_many :routes

  def send_confirmation_email
    # override to avoid sending any confirmation emails
  end
end

class User < ActiveRecord::Base
  include Clearance::User

  def send_confirmation_email
    # override to avoid sending any confirmation emails
  end
end

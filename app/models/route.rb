class Route < ActiveRecord::Base
  attr_accessor :email, :password

  attr_accessible :from, :to, :arrive_at, :email, :password

  belongs_to :user, :validate => true

  validates_presence_of :from, :to, :arrive_at
  
  validates_presence_of :email, :password, :on => :create

  validate :setup_user, :on => :create

  private

  def setup_user
    return unless user.nil?

    unless self.user = User.authenticate(email, password)
      if User.exists?(:email => email)
        errors[:password] << 'Incorrect password'
      else
        build_user(:email => email, :password => password) if user.nil?
      end
    end
  end
end

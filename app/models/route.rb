class Route < ActiveRecord::Base
  attr_accessor :email, :password, :to_address, :from_address

  attr_accessible :from_address, :to_address, :arrive_at, :email, :password

  belongs_to :user, :validate => true

  belongs_to :to, :class_name => 'Address'
  belongs_to :from, :class_name => 'Address'

  validates_presence_of :from_address, :to_address, :arrive_at
  
  validates_presence_of :email, :password, :on => :create

  validate :setup_user, :on => :create

  after_validation :setup_to_address, :setup_from_address, :on => :create


  class << self
    def distance_sql(address, address_table)
      quoted_address_table = connection.quote_column_name address_table

      lat1 = "RADIANS(#{connection.quote address.lat})"
      lng1 = "RADIANS(#{connection.quote address.lng})"

      lat2 = %{RADIANS(%s."lat")} % quoted_address_table
      lng2 = %{RADIANS(%s."lng")} % quoted_address_table

      <<-SQL
        2*ASIN(LEAST(1, POW(SIN((#{lat1} - #{lat2}) / 2.0), 2) + COS(#{lat1})*COS(#{lat2})*POW(SIN((#{lng1} - #{lng2}) / 2.0), 2)))
      SQL
    end

    def address_join(type)
      column_name = connection.quote_column_name [ type, 'addresses' ].join('_')

      %{INNER JOIN #{connection.quote_column_name 'addresses'} AS #{column_name} ON #{column_name}."id" = #{table_name}."#{type}_id"}
    end
  end

  scope :order_by_proximity, proc { |route|
    distance_sql = [ distance_sql(route.to, 'to_addresses'), distance_sql(route.from, 'from_addresses') ].join(' + ')

    { :joins => "#{address_join 'to'} #{address_join 'from'}", :order => "#{distance_sql} ASC" }
  }

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

  def setup_to_address
    build_to :address => to_address

    errors[:to_address] << 'Failed to look up' unless to.valid?
  end

  def setup_from_address
    build_from :address => from_address

    errors[:from_address] << 'Failed to look up' unless from.valid?
  end
end

class User < ActiveRecord::Base
  # acts_as_paranoid

  devise :rememberable, :database_authenticatable, :registerable, :trackable, :omniauthable, :omniauth_providers => [:twitter, :facebook, :linkedin, :google_oauth2, *(:developer if Rails.env.development?)]

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]

  has_many :votes, -> { includes :book }, dependent: :destroy

  has_many :owned_books, class_name: "Book", dependent: :destroy, inverse_of: :owner

  has_many :voted_books, -> { uniq }, through: :votes, source: :book, inverse_of: :voters

  has_many :given_likes, -> { where(liked: true) }, class_name: "Vote"

  has_many :ungiven_likes, -> { where(liked: false) }, class_name: "Vote"

  has_many :liked_books, -> { uniq }, through: :given_likes, source: :book, inverse_of: :likers

  has_many :disliked_books, -> { uniq }, through: :ungiven_likes, source: :book, inverse_of: :dislikers

  has_many :received_votes, through: :owned_books, source: :votes

  # GEOCODER
  geocoded_by :full_street_address   # can also be an IP address
  after_validation :geocode

  # SCOPES
  scope :people_in_range, -> (user) { where("id != ?", user.id ).near( [ user.latitude, user.longitude ], user.range ) }
  scope :all_likers, -> { joins(:votes).where('votes.liked = ?', true) }
  scope :all_voters, -> { joins(:votes).where('votes.user_id != ?', nil ) }

  # Validations


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
    end
  end

  def bookstack
    users_in_range.flat_map{ |user| user.owned_books }
  end


  private
    def self.ransackable_scopes(auth_object = nil)
      %i(active hired_since all_likers)
    end

end
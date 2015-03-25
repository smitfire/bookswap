class Vote < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  # SCOPES
  scope :liked, -> { where( liked: true ) }

end

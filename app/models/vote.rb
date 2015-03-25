class Vote < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  # SCOPES
  scope :liked, -> { where( liked: true ) }

  # Validations
  validates :user_id, :uniqueness => { :scope => :book_id }
  validates :book_id, :uniqueness => { :scope => :user_id }
  validate :cant_vote_on_own_book, if: "user_id.present?"

  private
    def cant_vote_on_own_book
      errors.add(:user_id, 'You cant vote on your own book idiot.') if self.user_id == book.owner.id
    end
end

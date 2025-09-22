class User < ApplicationRecord
  attribute :is_admin, :boolean, default: false

  has_many :picks, dependent: :destroy
  has_many :overall_picks, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end

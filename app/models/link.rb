class Link < ActiveRecord::Base
  belongs_to :user
  has_many :visits

  validates :slug, presence: true
  validates :target_url, presence: true

  def visit_count
    visits.count
  end


end

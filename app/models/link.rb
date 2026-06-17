class Link < ApplicationRecord
  has_many :clicks, dependent: :destroy

  validates :original_url, presence: true
  validates :short_code, presence: true, uniqueness: true

  after_update_commit  :clear_cache
  after_destroy_commit :clear_cache

  private

  def clear_cache
    Rails.cache.delete("link:#{short_code}")
  end
end

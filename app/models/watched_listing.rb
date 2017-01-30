# == Schema Information
#
# Table name: watched_listings
#
#  id         :integer          not null, primary key
#  owner_id   :string(255)
#  listing_id :integer
#

class WatchedListing < ActiveRecord::Base
  belongs_to :owner, :class_name => "Person", :foreign_key => "owner_id"
  belongs_to :listing

  validates :listing_id, :uniqueness => { :scope => :owner_id }
end

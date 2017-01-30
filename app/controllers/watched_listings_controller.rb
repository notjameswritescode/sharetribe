class WatchedListingsController < ApplicationController
  before_filter do |controller|
    controller.ensure_logged_in t("layouts.notifications.you_must_log_in_to_manage_watched_listings")
  end

  before_filter :set_listing, :only => [:create, :destroy]

  def show
    search = {
      # These are hard coded because we hope to show all the watched listings.
      page: 1,
      per_page: 1000,
      listing_ids: watched_listings_ids,
    }

    includes = [:author, :listing_images]

    listings = ListingIndexService::API::Api.listings.search(
      community_id: @current_community.id,
      search: search,
      engine: FeatureFlagHelper.search_engine,
      raise_errors: Rails.env.development?,
      includes: includes
    ).and_then { |res|
      Result::Success.new(
        ListingIndexViewUtils.to_struct(
          result: res,
          includes: includes,
          page: search[:page],
          per_page: search[:per_page]
        )
      )
    }.data

    render locals: { listings: listings, limit: search[:per_page] }
  end

  def create
    @current_user.watched_listings.create(listing: @listing)

    if request.xhr?
      render json: { translation: t("listings.show.watching") }, status: 201
    else
      flash_and_redirect_to_listing("added")
    end
  end

  def destroy
    @current_user.watched_listings.find_by(listing: @listing).destroy

    if request.xhr?
      render json: { translation: t("listings.show.watch") }, status: 200
    else
      flash_and_redirect_to_listing("removed")
    end
  end

  private

  def flash_and_redirect_to_listing(state)
    flash[:notice] = t("layouts.notifications.watch_#{state}", name: @listing.title)

    redirect_to listing_path(@listing)
  end

  def set_listing
    @listing = Listing.find(params.require(:listing_id))
  end

  def watched_listings_ids
    Listing.find(@current_user.watched_listings.pluck(:listing_id)).map(&:id)
  end
end

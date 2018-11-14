class CategorySweeper < ActionController::Caching::Sweeper
  # Used to cache the database-intensive categories listing
  # Categories are nested and result in many DB calls, but it only needs
  # to be done on first load, then cached, since they rarely change
  observe Category

  def after_save(category)
    expire_cache(category)
  end

  def after_destroy(category)
    expire_cache(category)
  end

  def expire_cache(category)
    expire_fragment 'categories'
  end

end

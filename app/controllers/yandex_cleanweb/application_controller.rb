module YandexCleanweb
  class ApplicationController < ::ApplicationController
    layout false
    skip_before_filter :change_country, :set_random_amount_of_users
  end
end
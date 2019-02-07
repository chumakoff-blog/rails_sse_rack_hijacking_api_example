class HomeController < ApplicationController
  def index
    @methods = {
      ac_live: "ActionController::Live",
      full_hijack: "Rack Hijacking API (Full)",
      partial_hijack: "Rack Hijacking API (Partial)"
    }
  end
end

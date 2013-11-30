class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_headers

  def set_headers
    headers["Access-Control-Allow-Origin"]  = "*"
    headers["Access-Control-Allow-Methods"] = %w{GET POST PUT DELETE OPTIONS}.join(",")
    head(:ok) if request.request_method == "OPTIONS"
  end
end

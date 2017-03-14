class ApplicationController < ActionController::API

  respond_to?(:random_record)

  def random_record(entry_set)
    entry_set.sample
  end
end

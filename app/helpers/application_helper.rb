module ApplicationHelper
  def paginate(objects)
    if objects
      will_paginate objects
    end
  end
end

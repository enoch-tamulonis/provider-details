class ApplicationController < ActionController::Base
  def append_turbo_modal(frame, url)
    turbo_stream.append("body",
      partial: "modal/modal",
      locals: {
        frame: frame,
        url: url
      })
  end
end

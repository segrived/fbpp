class Api::ApiController < ApplicationController

    def render_error(error_text)
        render :json => [ :error => error_text ]
    end

end
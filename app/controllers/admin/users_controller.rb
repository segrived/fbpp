class Admin::UsersController < Admin::AdminController

    def list
        @users = User.all
    end

end
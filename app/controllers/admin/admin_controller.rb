class Admin::AdminController < ApplicationController
  before_filter :require_admin_rights
end
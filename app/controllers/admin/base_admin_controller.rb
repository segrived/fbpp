class Admin::BaseAdminController < ApplicationController
  before_filter :require_admin_rights
end
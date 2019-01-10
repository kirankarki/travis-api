module Travis::API::V3
  class Services::BetaMigrationRequest::Create < Service
    result_type :beta_migration_request

    def run!
      raise LoginRequired unless access_control.logged_in?
      #result query.for_user(access_control.user)
      current_user = access_control.user

      result query(:beta_migration_request).create(current_user)
    end
  end
end

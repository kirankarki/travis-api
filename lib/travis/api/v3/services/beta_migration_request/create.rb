module Travis::API::V3
  class Services::BetaMigrationRequest::Create < Service
    params :organizations, prefix: :beta_migration_request
    result_type :beta_migration_request

    def run!
      puts "logged in"
      raise LoginRequired unless access_control.logged_in?
      current_user = access_control.user

      beta_migration_request = query(:beta_migration_request).create(current_user)

      valid_orgs =
        params[:organizations].select do |org_id|
           query(:memberships).find({role: "admin", organization_id: org_id, user_id: current_user.id})
        end

      beta_migration_request.organizations =
        valid_orgs.map{ |org_id| query(:organization).find({id: org_id}) }

      beta_migration_request.save!

      result beta_migration_request
    end
  end
end

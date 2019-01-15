module Travis::API::V3
  class Queries::Memberships < Query
    params :user_id, :organization_id, :role

    def find
      Models::Membership.where(params)
    end
  end
end
